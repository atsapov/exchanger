class UsersController < ApplicationController
  before_filter :signed_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Exchanger!"
      redirect_to purses_path
    else
      render 'new'
    end
  end

  private

    def signed_user
      redirect_to purses_path if signed_in?
    end
end
