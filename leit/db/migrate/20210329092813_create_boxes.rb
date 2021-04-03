# frozen_string_literal: true

class CreateBoxes < ActiveRecord::Migration[6.1]
  def change
    create_table :boxes do |t|
      t.string :title
      t.text :desc
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
