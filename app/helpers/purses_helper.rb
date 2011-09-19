module PursesHelper

  private

    def define_purses
      @purse1 = current_user.purses.find_by_currency_id(@exchange.bought_id)
      @purse2 = current_user.purses.find_by_currency_id(@exchange.sold_id)
      @purse3 = admin_user.purses.find_by_currency_id(@exchange.bought_id)
      @purse4 = admin_user.purses.find_by_currency_id(@exchange.sold_id)
    end
end
