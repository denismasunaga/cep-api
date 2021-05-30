class AddUserToCeps < ActiveRecord::Migration[6.1]
  def change
    add_reference :ceps, :user, null: false, foreign_key: true
  end
end
