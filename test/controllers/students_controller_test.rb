require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @student = create(:student)
    @user = create(:user)
    sign_in @user
  end

  test "should get index" do
    get students_url
    assert_response :success
  end

  test "should get new" do
    get new_student_url
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post students_url, params: { student: { name: 'Test', surname: 'Student', second_surname: 'One', email: 'test@student.com', wallet_address: 'test_address' } }
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should show student" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student" do
    patch student_url(@student), params: { student: { name: 'Updated', surname: 'Student', second_surname: 'One', email: 'updated@student.com', wallet_address: 'updated_address' } }
    assert_redirected_to student_url(@student)
    @student.reload
    assert_equal 'Updated', @student.name
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end
