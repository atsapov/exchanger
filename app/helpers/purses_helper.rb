module PursesHelper

  private

    def purse_user_bought
      @purse_user_bought = 
                  current_user.purses.find_by_currency_id(@exchange.bought_id)
    end

    def purse_user_sold
      @purse_user_sold = 
                  current_user.purses.find_by_currency_id(@exchange.sold_id)
    end

    def purse_admin_bought
      @purse_admin_bought = 
                   admin_user.purses.find_by_currency_id(@exchange.bought_id)
    end

    def purse_admin_sold
      @purse_admin_sold = 
                   admin_user.purses.find_by_currency_id(@exchange.sold_id)
    end
end
