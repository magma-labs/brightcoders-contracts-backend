class NftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student

  def new
    @nft = Nft.new
  end

  def create
    @nft = @student.nfts.build(nft_params)

    if nft_params['name'].present? && nft_params['description'].present? && nft_params['image_temp'].present?
      response = NftMinter.mint_nft(nft_params_with_student_id)
  
      if response[:success]
        @nft.token_id = response[:token_id]
        @nft.ipfs_metadata = response[:ipfs_metadata]
        @nft.ipfs_image = response[:ipfs_image]
  
        if @nft.save
          flash[:notice] = "NFT minted successfully"
          redirect_to student_path(@student)
        else
          flash[:alert] = "NFT minted successfully an error ocurred saving NFT: #{nft.errors.full_messages.to_sentence}"
          render :new
        end
      else
        flash[:alert] = "Error minting NFT: #{response[:error_message]}"
        render :new
      end
    else
      flash[:alert] = "Error creating NFT: Missing parameters"
      render :new
    end
  end  

  def destroy
    @nft = @student.nfts.find(params[:id])
    @nft.destroy
    flash[:notice] = "NFT de-associated successfully"
    redirect_to student_path(@student)
  end

  private

  def set_student
    @student = Student.find(params[:student_id])
  end

  def nft_params
    params.require(:nft).permit(:name, :description, :image_temp)
  end

  def nft_params_with_student_id
    nft_params.merge(student_id: @student.id)
  end
end
