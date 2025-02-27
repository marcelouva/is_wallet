
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.string :full_name
      t.string :phone_number
      t.boolean :is_verified, default: false
      t.string :auth_token
      t.string :profile_picture_url
      t.boolean :is_active, default: true
      t.datetime :dob
      t.string :language_preference, default: 'en'
      
      t.timestamps
    end
  end
end
