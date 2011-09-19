class ExchangesController < ApplicationController
  before_filter :authenticate, :except => :index
  before_filter :select_all_currencies
  before_filter :define_values,
                :invalid_input_data,
                :no_selected_purse,
		:user_has_no_money,
		:admin_has_no_money, :only => :up_change

  def index
  end

  def change
    @exchange = Exchange.new
  end

  def up_change
    @exchange.change(@purse1, @purse2, @purse3, @purse4, @rate)
    flash[:success] = "Currencies were successful changed."
    redirect_to purses_path
  end

  private

    def invalid_input_data
      if @exchange.invalid?
        render 'change'
      end
    end

    def no_selected_purse
      if @purse1.nil? or @purse2.nil?  
        flash.now[:error] = "You don't have a purse with selected currency. 
                             For this action you must create it."
        render 'change'
      end
    end

    def user_has_no_money
      @rate = Exchange.find_by_bought_id_and_sold_id(@exchange.bought_id, 
                                                     @exchange.sold_id).rate
      if @purse2.content < @exchange.rate*@rate
        flash.now[:error] = "For this action you must have 
          #{@exchange.rate*@rate} #{@sold_symbol}, but you have only 
          #{@purse2.content} #{@sold_symbol}..."
        render 'change'
      end
    end

    def admin_has_no_money
      if @purse3.content < @exchange.rate
        flash.now[:error] = "The system doesn't have 
          #{@exchange.rate} #{@bought_symbol}, it has only 
          #{@purse3.content} #{@bought_symbol}. It be cost 
          #{@purse3.content*@rate} #{@sold_symbol}."
        render 'change'
      end
    end
end
