module CurrenciesHelper

  private

    def select_all_currencies
      @currencies = Currency.all
    end

    def user_currencies_array
      c_array = []
      Currency.all.each do |currency|
        if current_user.purses.find_by_currency_id(currency)
          c_array << [currency.symbol, currency.id]
        end
      end
      c_array
    end

    def no_user_currencies_array
      c_array = []
      Currency.all.each do |currency|
        if current_user.purses.find_by_currency_id(currency).nil?
          c_array << [currency.symbol, currency.id]
        end
      end
      c_array
    end
end
