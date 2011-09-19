class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include UsersHelper
  include ExchangesHelper
  include CurrenciesHelper
  include PursesHelper
end
