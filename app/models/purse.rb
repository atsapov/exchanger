class Purse < ActiveRecord::Base
#  attr_accessible :user_id, :currency_id, :content, :put, :output
#  attr_accessor :user_id, :currency_id, :content, :put, :output

  belongs_to :user
  belongs_to :currency

  validates :user_id, :presence   => true
  validates :currency_id, :presence   => true
  validates :put, :inclusion => { :in => 0..1000000 }
  validates :output, :inclusion => { :in => 0..1000 }

  def initial(user_id)
    self.user_id = user_id
    self.content = 0
    self.put = 0
    self.output = 0
  end

  def put_money
    self.content += self.put
    self.put = 0
    self.save
  end

  def output_money
    self.content -= self.output
    self.output = 0
    self.save
  end
end
