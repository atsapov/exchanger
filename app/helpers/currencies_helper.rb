module CurrenciesHelper

  private

    def select_all_currencies
      @currencies = Currency.all
    end

    def define_symbols
      @bought_symbol = Currency.find(@exchange.bought_id).symbol
      @sold_symbol = Currency.find(@exchange.sold_id).symbol
    end
end
