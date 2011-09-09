class Currency < ActiveRecord::Base
  symbol_regex = /^[A-Z]{3}$/

  validates :symbol, :presence => true,
                     :format   => { :with => symbol_regex },
                     :uniqueness => true

  has_many :purses, :dependent => :destroy
end
