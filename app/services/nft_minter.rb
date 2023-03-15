require 'httparty'

class NftMinter
  include HTTParty

  def self.mint_nft(nft)
    url = 'https://node-app.com/mint_nft' # Replace with the URL of the node app of Javi

    options = {
      headers: { 'Content-Type' => 'multipart/form-data' },
      body: {
        name: nft.name,
        description: nft.description,
        student: nft.student,
        image: nft.image_temp
      }
    }

    response = #post(url, options)

    if true #response.code == 200
      # Handle success
      # Return the response or an object containing the result
      { success: true }
    else
      # Handle error
      { success: false, error_message: response.message }
    end
  end
end
