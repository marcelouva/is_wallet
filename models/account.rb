class Account < ActiveRecord::Base
    belongs_to :user  # Relación con la tabla users
  
    # Validaciones
    validates :currency, presence: true, inclusion: { in: ['USD', 'ARS','EUR'] }  # Asegura que la moneda esté en el conjunto de valores permitidos
    validates :balance, numericality: { greater_than_or_equal_to: 0 }
  end
  