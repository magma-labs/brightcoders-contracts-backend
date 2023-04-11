class NftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student

  def new
    @nft = Nft.new
  end

  def create
    course = Course.find(nft_params[:course_id])
  
    if course.present?
      mint_params = {
        name: course.title,
        description: course.description,
        image_temp: course.image,
        student: @student
      }
  
      response = NftMinter.mint_nft(mint_params)
  
      if response[:success]
        @nft = @student.nfts.build(
          course_id: course.id,
          name: course.title,
          description: course.description,
          token_id: response[:token_id],
          ipfs_metadata: response[:ipfs_metadata],
          ipfs_image: response[:ipfs_image]
        )
  
        if @nft.save
          flash[:notice] = "NFT minted successfully"
          redirect_to student_path(@student)
        else
          flash[:alert] = "NFT minted successfully but an error occurred while saving NFT: #{@nft.errors.full_messages.to_sentence}"
          render :new
        end
      else
        flash[:alert] = "Error minting NFT: #{response[:error_message]}"
        render :new
      end
    else
      flash[:alert] = "Error creating NFT: Invalid course"
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

  def nft_params
    params.require(:nft).permit(:course_id, :image_temp)
  end  

  def nft_params_with_student_id
    nft_params.merge(student_id: @student.id)
  end
end
