require "test_helper"

class NftsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @student = create(:student)
    sign_in create(:user)
  end

  test "should get new" do
    get new_student_nft_url(@student)
    assert_response :success
  end

  test "should create nft" do
    assert_difference('Nft.count') do
      post student_nfts_url(@student), params: { nft: attributes_for(:nft) }
    end

    assert_redirected_to student_path(@student)
    assert_equal "NFT minted successfully", flash[:notice]
  end

  test "should destroy nft" do
    nft = create(:nft, student: @student)
    assert_difference('Nft.count', -1) do
      delete student_nft_url(@student, nft)
    end

    assert_redirected_to student_path(@student)
    assert_equal "NFT de-associated successfully", flash[:notice]
  end
end
