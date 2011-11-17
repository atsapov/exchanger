class Purse < ActiveRecord::Base
  attr_accessor :money

  belongs_to :user
  belongs_to :currency

  validates :user_id,     :presence => true
  validates :currency_id, :presence => true
  validates :money,       :numericality => {:greater_than => 0},
                          :allow_nil => true

  validate :content_validate

  after_validation :money_to_f

  def put_output(money)
    self.content += money.round(2)
    self.save
  end

  def has_money?(money)
    @money = money
    self.put_output(-money)
  end

  private

    def content_validate
      message if self.content < 0
    end

    def message
      if self.user.admin?
        admin_has_no_money
      else
        user_has_no_money
      end
    end

    def admin_has_no_money
      errors.add(:base, "The system doesn't have 
          #{self.money} #{self.currency.symbol}, it has only 
          #{self.reload.content} #{self.currency.symbol}.")
    end

    def user_has_no_money
      errors.add(:base, "For this action you must have 
          #{self.money} #{self.currency.symbol}, but you have only 
          #{self.reload.content} #{self.currency.symbol}...")
    end

    def money_to_f
      @money = @money.to_f unless @money.nil?
    end
end
