namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
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

