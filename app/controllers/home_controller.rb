class HomeController < ApplicationController
  before_action :redirect_if_logged_in, only: [:index]

  def index
  end

  private

  def redirect_if_logged_in
    redirect_to students_path if user_signed_in?
  end
end
