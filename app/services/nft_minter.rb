require 'open3'

class NftMinter
  def self.mint_nft(nft_params)
    name = nft_params[:name]
    description = nft_params[:description]
    image = nft_params[:image_temp]
    student_id = nft_params[:student].id

    student = Student.find(student_id)
    receiver = student.wallet_address

    # Read values from environment variables
    contract_repo_path = ENV['CONTRACT_REPO_PATH']
    contract = ENV['CONTRACT_ADDRESS']
    network = ENV['CONTRACT_NETWORK']

    # Get the temporary image file path
    image_file_path = create_temp_image_file(image)

    # Build the CLI command
    cmd = [
      'npx hardhat compile && npx hardhat mint',
      "--contract #{contract}",
      "--receiver #{receiver}",
      "--name \"#{name}\"",
      "--description \"#{description}\"",
      "--student \"#{student.id}\"",
      "--imagefilename #{image_file_path}",
      "--network #{network}"
    ].join(' ')

    puts "Executing CLI command: #{cmd}"

    stdout, stderr, status = nil

    # Execute the CLI command in the specified path and capture the output
    Dir.chdir(contract_repo_path) do
      stdout, stderr, status = Open3.capture3(cmd)
    end

    if status.success?
      # If the command succeeded, parse the output and return the relevant data
      token_id, ipfs_metadata, ipfs_image = parse_output(stdout)
      { success: true, token_id: token_id, ipfs_metadata: ipfs_metadata, ipfs_image: ipfs_image }
    else
      # If the command failed, return an error message
      { success: false, error_message: "Failed to mint NFT using CLI command: #{stderr}" }
    end
  ensure
    # Remove the temporary image file
    File.delete(image_file_path) if image_file_path && File.exist?(image_file_path)
  end

  def self.create_temp_image_file(image)
    image_blob = image.blob
    temp_file = Tempfile.new([image_blob.filename.base, image_blob.filename.extension_with_delimiter])
    temp_file.binmode
    temp_file.write(image_blob.download)
    temp_file.rewind
    temp_file.path
  end

  def self.parse_output(output)
    token_id = /tokenId:\s+(\d+)/.match(output)&.[](1)
    metadata_cid = /metadataCID:\s+'(\S+\/metadata.json)'/.match(output)&.[](1)
    ipfs_image = "#{metadata_cid.gsub('metadata.json', 'image')}"
  
    [token_id, metadata_cid, ipfs_image]
  end  
end
