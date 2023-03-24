require 'open3'

class NftMinter
  def self.mint_nft(nft_params)
    permitted_params = nft_params.permit(:name, :description, :image_temp, :student_id)

    student = Student.find(permitted_params[:student_id])
    receiver = student.wallet_address

    # Read values from environment variables
    contract_repo_path = ENV['CONTRACT_REPO_PATH']
    contract = ENV['CONTRACT_ADDRESS']
    network = ENV['CONTRACT_NETWORK']

    # Get the temporary image file path
    image_file_path = permitted_params[:image_temp].tempfile.path

    # Build the CLI command
    cmd = [
      'npx hardhat mint',
      "--contract #{contract}",
      "--receiver #{receiver}",
      "--name \"#{permitted_params[:name]}\"",
      "--description \"#{permitted_params[:description]}\"",
      "--student \"#{student.id}\"",
      "--imagefilename #{image_file_path}",
      "--network #{network}"
    ].join(' ')

    stdout, stderr, status = nil

    # Execute the CLI command in the specified path and capture the output
    Dir.chdir(contract_repo_path) do
      stdout, stderr, status = Open3.capture3(cmd)
    end

    # debugger
    if status.success?
      # If the command succeeded, parse the output and return the relevant data
      token_id, ipfs_metadata, ipfs_image = parse_output(stdout)
      { success: true, token_id: token_id, ipfs_metadata: ipfs_metadata, ipfs_image: ipfs_image }
    else
      # If the command failed, return an error message
      { success: false, error_message: "Failed to mint NFT using CLI command: #{stderr}" }
    end
  end

  def self.parse_output(output)
    token_id = /tokenId:\s+(\d+)/.match(output)&.[](1)
    metadata_cid = /metadataCID:\s+'(\S+\/metadata.json)'/.match(output)&.[](1)
    ipfs_image = "#{metadata_cid.gsub('metadata.json', 'image')}"
  
    [token_id, metadata_cid, ipfs_image]
  end  
end
