# app/controllers/nfts_controller.rb
class NftsController < ApplicationController
  def new
    @nft = Nft.new
  end

  def create
    response = NftMinter.mint_nft(nft_params)

    if response[:success]
      @nft = Nft.new(nft_params)

      if @nft.save
        flash[:notice] = "NFT minted and saved successfully"
      else
        flash[:alert] = "NFT minted, but error saving to database: #{@nft.errors.full_messages.join(', ')}"
      end

      redirect_to new_nft_path
    else
      flash[:alert] = "Error minting NFT: #{response[:error_message]}"
      render :new
    end
  end

  private

  def nft_params
    params.require(:nft).permit(:name, :description, :student)
  end
end
