class PursesController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :except => [:index, :new, :create]

  def index
    @purses = current_user.purses
  end

  def new
    @purse = Purse.new
  end

  def create
    @purse = Purse.new(params[:purse])
    @purse.initial(current_user.id)
    if @purse.save
      flash[:success] = "The purse is created!"
      redirect_to purses_path
    else
      render 'new'
    end
  end

  def put
  end

  def output
  end

  def up_put
    if @purse.update_attributes(params[:purse])
      @purse.put_money
      flash[:success] = "Money has been put."
      redirect_to purses_path
    else
      render 'put'
    end
  end

  def up_output
    if @purse.update_attributes(params[:purse])
      @purse.output_money
      flash[:success] = "Money has been outputted."
      redirect_to purses_path
    else
      render 'output'
    end
  end

  def destroy
    @purse.destroy
    flash[:success] = "Purse deleted."
    redirect_to purses_path
  end

  private

    def correct_user
      @user = User.find(current_purse.user_id)
      redirect_to purses_path unless current_user?(@user)
    end

    def current_purse
      @purse = Purse.find(params[:id])
    end
end
