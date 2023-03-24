require 'test_helper'

class NftTest < ActiveSupport::TestCase
  def setup
    @nft = build(:nft)
  end

  test "should be valid" do
    assert @nft.valid?
  end

  test "name should be present" do
    @nft.name = " "
    assert_not @nft.valid?
  end

  test "description should be present" do
    @nft.description = " "
    assert_not @nft.valid?
  end

  test "student should be present" do
    @nft.student = nil
    assert_not @nft.valid?
  end

  test "image_temp should be present" do
    @nft.image_temp = nil
    assert_not @nft.valid?
  end

  test "token_id should be present" do
    @nft.token_id = nil
    assert_not @nft.valid?
  end

  test "ipfs_metadata should be present" do
    @nft.ipfs_metadata = nil
    assert_not @nft.valid?
  end

  test "ipfs_image should be present" do
    @nft.ipfs_image = nil
    assert_not @nft.valid?
  end
end
