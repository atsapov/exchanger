class PursesController < ApplicationController
  before_filter :current_purse, :except => [:index, :new, :create]
  before_filter :no_money, :only => :up_output

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

    def current_purse
      @purse = Purse.find(params[:id])
    end

    def no_money
      if params[:purse][:output].to_f > @purse.content
        flash[:error] = "You don't have so much money..."
        render 'output'
      end
    end
end
