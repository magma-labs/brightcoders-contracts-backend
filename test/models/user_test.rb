require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should find a user from omniauth data" do
    auth_data = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "123",
      info: { email: @user.email }
    })
  
    user = User.from_omniauth(auth_data)
  
    assert_not_nil user
    assert_equal auth_data.info.email, user.email
  end
end
