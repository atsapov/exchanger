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
                  :content => 100,
                  :put => 0,
                  :output => 0)
  end
end

def make_exchanges
  number = Currency.count
  number.times do |bought|
    number.times do |sold|
      if bought != sold
        rate = 2 + rand(8)
        Exchange.create!(:bought_id => bought+1,
			 :sold_id => sold+1,
			 :rate => rate)
      end
    end
  end
end

