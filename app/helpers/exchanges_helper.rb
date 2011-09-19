module ExchangesHelper

  private

    def define_values
      @exchange = Exchange.new(params[:exchange])
      define_purses
      define_symbols
    end
end
