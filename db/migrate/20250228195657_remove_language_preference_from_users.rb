class RemoveLanguagePreferenceFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :language_preference, :string
  end
end
