class User < ActiveRecord::Base
    has_secure_password  # Esto requiere la gema bcrypt para gestionar la contraseña segura
    has_many :accounts, dependent: :destroy  # Un usuario puede tener muchas cuentas
  
    # Validaciones
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, on: :create  # Se valida la contraseña solo al crear el usuario
  end
  