require 'httparty'

class NftMinter
  include HTTParty

  def self.mint_nft(nft_params)
    permitted_params = nft_params.permit(:name, :description, :image_temp)

    url = 'https://node-app.com/mint_nft' # Replace with the URL of the node app of Javi

    options = {
      headers: { 'Content-Type' => 'multipart/form-data' },
      body: {
        name: permitted_params[:name],
        description: permitted_params[:description],
        student: permitted_params[:student],
        image: permitted_params[:image_temp]
      }
    }


    response = #post(url, options)

    if true #response.code == 200
      { success: true, token_id: 1, ipfs_metadata: '2', ipfs_image: '3' }
    else
      { success: false, error_message: response.message }
    end
  end
end
