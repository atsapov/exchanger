class Currency < ActiveRecord::Base
  symbol_regex = /^[A-Z]{3}$/

  validates :symbol, :presence => true,
                     :format   => { :with => symbol_regex },
                     :uniqueness => true

  has_many :purses

  has_many :exchanges, :foreign_key => "bought_id",
                           :dependent => :destroy
  has_many :sold, :through => :exchanges, :source => :sold
  has_many :reverse_exchanges, :foreign_key => "sold_id",
                                   :class_name => "Exchange",
                                   :dependent => :destroy
  has_many :bought, :through => :reverse_exchanges, :source => :bought

  def rate(sold)
    Exchange.find_by_bought_id_and_sold_id(self, sold).rate
  end
end
