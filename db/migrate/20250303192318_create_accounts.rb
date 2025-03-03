class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true, null: false  # Relación con el usuario
      t.string :bank_name, null: false                    # Nombre del banco
      t.string :cbu, null: false, unique: true            # CBU único
      t.string :alias, unique: true                       # Alias único
      t.decimal :balance, precision: 15, scale: 2, default: 0.0 # Saldo inicial
      t.string :currency, null: false, default: "ARS"     # Moneda de la cuenta (ARS, USD, EUR, etc.)
      t.timestamps
    end
  end
end
