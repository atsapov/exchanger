class PursesController < ApplicationController

  def index
    @purses = current_user.purses
  end

  def new
    @purse = Purse.new
  end

  def create
    @purse = Purse.new(params[:purse])
    @purse.user_id = current_user.id
    @purse.content = 0
    @purse.put = 0
    @purse.output = 0
    if @purse.save
      flash[:success] = "The purse is created!"
      redirect_to purses_path
    else
      render 'new'
    end
  end

  def put
    @purse = Purse.find(params[:id])
  end

  def output
    @purse = Purse.find(params[:id])
  end

  def up_put
    @purse = Purse.find(params[:id])
    if @purse.update_attributes(params[:purse])
      @purse.content += @purse.put
      @purse.put = 0
      @purse.save
      flash[:success] = "Money has been put."
      redirect_to purses_path
    else
      render 'put'
    end
  end

  def up_output
    @purse = Purse.find(params[:id])
    if params[:purse][:output].to_f > @purse.content
      flash[:error] = "You don't have so much money..."
      render 'output'
    else
      if @purse.update_attributes(params[:purse])
        @purse.content -= @purse.output
        @purse.output = 0
        @purse.save
        flash[:success] = "Money has been outputted."
        redirect_to purses_path
      else
        render 'output'
      end
    end
  end

  def destroy
    Purse.find(params[:id]).destroy
    flash[:success] = "Purse deleted."
    redirect_to purses_path
  end
end
