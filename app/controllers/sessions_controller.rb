class SessionsController < ApplicationController
  def new
  end
  def destroy
    sign_out current_user
    redirect_to root_path, notice: 'Signed out successfully.'
  end
end
