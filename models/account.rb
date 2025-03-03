class Account < ActiveRecord::Base
    belongs_to :user  # Relación con la tabla users

    # Validaciones
    validates :currency, presence: true, inclusion: { in: ['USD', 'ARS','EUR'] }  # Asegura que la moneda esté en el conjunto de valores permitidos
    validates :balance, numericality: { greater_than_or_equal_to: 0 }
  end


  class Account < ActiveRecord::Base
  belongs_to :user  # Una cuenta pertenece a un usuario
  has_many :transactions, dependent: :destroy  # Una cuenta tiene muchas transacciones

  # Validaciones
  validates :bank_name, presence: true
  validates :cbu, presence: true, uniqueness: true
  validates :alias, uniqueness: true, allow_nil: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true, inclusion: { in: %w[ARS USD EUR BRL] } # Monedas permitidas
end
