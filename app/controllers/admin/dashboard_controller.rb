# app/controllers/admin/dashboard_controller.rb
class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
  end
end
