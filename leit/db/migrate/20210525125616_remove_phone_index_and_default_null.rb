# frozen_string_literal: true

class RemovePhoneIndexAndDefaultNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:users, :phone, true)
    remove_index :users, :phone
  end
end
