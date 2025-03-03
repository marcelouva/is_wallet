class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :origin_account, foreign_key: { to_table: :accounts }, null: false  # Cuenta origen
      t.references :destination_account, foreign_key: { to_table: :accounts }, null: false  # Cuenta destino
      t.decimal :amount, precision: 15, scale: 2, null: false  # Monto de la transacción
      t.string :reason, null: false  # Motivo de la transacción
      t.timestamps  # Maneja automáticamente created_at (instante de la transacción)
    end
  end
end
