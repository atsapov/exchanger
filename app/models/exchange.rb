class Exchange < ActiveRecord::Base

  belongs_to :bought, :class_name => "Currency"
  belongs_to :sold, :class_name => "Currency"

  validates :bought_id, :presence => true
  validates :sold_id, :presence => true

  validates :rate, :numericality => { :greater_than => 0 }

  validate :currencies_must_be_different

  after_validation :round_value

  def change(purse1, purse2, purse3, purse4, rate)
    purse1.content += self.rate
    purse2.content -= self.rate*rate
    purse3.content -= self.rate
    purse4.content += self.rate*rate
    [purse1, purse2, purse3, purse4].each{|purse| 
                     purse.update_attribute(:content, purse.content)}
  end

  private

    def currencies_must_be_different
      errors.add(:base, "The bought and sold currencies must be 
		 different.") if self.bought_id == self.sold_id
    end

    def round_value
      self.rate = self.rate.round(2) unless self.rate.nil?
    end
end

