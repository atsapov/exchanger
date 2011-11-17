class Exchange < ActiveRecord::Base
  attr_accessor :money

  belongs_to :bought, :class_name => "Currency"
  belongs_to :sold,   :class_name => "Currency"

  validates :bought_id, :presence => true
  validates :sold_id,   :presence => true
  validates :money,     :numericality => {:greater_than => 0},
                        :allow_nil => true

  validate :currencies_must_be_different

  after_validation :money_to_f

  def change(p_user_b, p_user_s, p_admin_b, p_admin_s)
#   Проверка: достаточно ли у пользователя денег для покупки валюты
    if p_user_s.has_money?(self.money*current_rate)
      next_step(p_user_b, p_user_s, p_admin_b, p_admin_s)
    end
  end

  private

    def next_step(p_user_b, p_user_s, p_admin_b, p_admin_s)
#     Проверка: есть ли в наличии необходимое пользователю количество валюты
      if p_admin_b.has_money?(self.money)
        put_to_user_and_admin_purses(p_user_b, p_admin_s)
      else
#       Возвращаем пользователю взятые у него деньги
        p_user_s.put_output(self.money*current_rate)
        false
      end
    end

    def put_to_user_and_admin_purses(user_purse, admin_purse)
      user_purse.put_output(self.money)
      admin_purse.put_output(self.money*current_rate)
    end

    def current_rate
      if self.bought_id < self.sold_id
        current_bought_rate
      else
        current_sold_rate
      end
    end

    def current_bought_rate
      Exchange.find_by_bought_id_and_sold_id(self.bought_id,
                                             self.sold_id).bought_rate
    end

    def current_sold_rate
      Exchange.find_by_bought_id_and_sold_id(self.sold_id,
                                             self.bought_id).sold_rate
    end

    def currencies_must_be_different
      errors.add(:base, "The bought and sold currencies must be 
                 different.") if self.bought_id == self.sold_id
    end

    def money_to_f
      @money = @money.to_f unless @money.nil? or @money.empty?
    end
end

