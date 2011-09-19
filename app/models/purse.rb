class Purse < ActiveRecord::Base

  belongs_to :user
  belongs_to :currency

  validates :user_id,     :presence => true
  validates :currency_id, :presence => true
  validates :content, :numericality => {:greater_than_or_equal_to => 0}
  validates :put,     :numericality => {:greater_than => 0}, :on => :update, 
                      :if => "output == 0"
  validates :output,  :numericality => {:greater_than => 0}, :on => :update, 
                      :if => "put == 0"

  before_update :round_value

  def initial(user_id)
    self.user_id = user_id
    self.content = 0
    self.put = 0
    self.output = 0
  end

  def put_money
    Purse.update_counters(self.id, :content => self.put, :put => -self.put)
  end

  def output_money
    Purse.update_counters(self.id, :content => -self.output, 
                          :output => -self.output)
  end

  private

    def round_value
      self.content = self.content.round(2)
      self.put = self.put.round(2)
      self.output = self.output.round(2)
    end
end
