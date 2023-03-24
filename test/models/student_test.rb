require "test_helper"

class StudentTest < ActiveSupport::TestCase
  def setup
    @student = build(:student)
  end

  test "should be valid" do
    assert @student.valid?
  end

  test "name should be present" do
    @student.name = " "
    assert_not @student.valid?
  end

  test "surname should be present" do
    @student.surname = " "
    assert_not @student.valid?
  end

  test "second surname should be present" do
    @student.second_surname = " "
    assert_not @student.valid?
  end

  test "email should be present" do
    @student.email = " "
    assert_not @student.valid?
  end

  test "wallet address should be present" do
    @student.wallet_address = " "
    assert_not @student.valid?
  end

  test "email should be unique" do
    duplicate_student = @student.dup
    @student.save
    assert_not duplicate_student.valid?
  end
end
