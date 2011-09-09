class Purse < ActiveRecord::Base

  belongs_to :user
  belongs_to :currency

  validates :user_id, :presence   => true
  validates :currency_id, :presence   => true
  validates :put, :inclusion => { :in => 0..1000000 }
  validates :output, :inclusion => { :in => 0..1000 }

end
