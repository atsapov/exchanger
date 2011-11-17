class ExchangesController < ApplicationController
  before_filter :authenticate, :except => :index
  before_filter :select_all_currencies

  def index
  end

  def change
    @exchange = Exchange.new
  end

  def up_change
    @exchange = Exchange.new(params[:exchange])
    if @exchange.valid? and @exchange.change(purse_user_bought, purse_user_sold,
                                           purse_admin_bought, purse_admin_sold)
      flash[:success] = "Currencies were successful changed."
      redirect_to purses_path
    else
      render 'change'
    end
  end
end
