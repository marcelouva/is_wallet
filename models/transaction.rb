class Transaction < ActiveRecord::Base
  belongs_to :origin_account, class_name: "Account"
  belongs_to :destination_account, class_name: "Account"

  # Validaciones
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :reason, presence: true
  validate :same_currency_accounts
  validate :sufficient_balance

  private

  def same_currency_accounts
    if origin_account.currency != destination_account.currency
      errors.add(:base, "Las cuentas deben tener la misma moneda")
    end
  end

  def sufficient_balance
    if origin_account.balance < amount
      errors.add(:amount, "Saldo insuficiente en la cuenta de origen")
    end
  end
end
