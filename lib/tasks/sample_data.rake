namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_currencies
    make_admin_purses
    make_exchanges
  end
end

def make_users
  password  = "password"
  admin = User.create!(:login => "example",
                       :password => password,
                       :password_confirmation => password)
  admin.toggle!(:admin)
  4.times do |n|
    login = "example-#{n+1}"
    User.create!(:login => login,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_currencies
  symbols  = ['EUR', 'GBP', 'RUR', 'UAH', 'USD']
  symbols.each do |n|
    Currency.create!(:symbol => n)
  end
end

def make_admin_purses
  Currency.count.times do |i|
    Purse.create!(:user_id => 1,
                  :currency_id => i+1,
                  :content => 100)
  end
end

def make_exchanges
  number = Currency.count
  1.upto(number-1) do |bought|
    (bought+1).upto(number) do |sold|
        bought_rate = 2 + rand(8)
        sold_rate = (1.0/bought_rate).round(2)
        Exchange.create!(:bought_id => bought,
			 :sold_id => sold,
			 :bought_rate => bought_rate,
			 :sold_rate => sold_rate)
    end
  end
end

