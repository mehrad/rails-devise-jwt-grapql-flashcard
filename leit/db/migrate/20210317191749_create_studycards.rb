class CreateStudycards < ActiveRecord::Migration[6.1]
  def change
    create_table :studycards do |t|
      t.string :hint
      t.timestamp :first_studied_at
      t.timestamp :last_studied_at
      t.integer :state
      t.integer :house
      t.integer :reset_count
      t.integer :visit_count
      t.references :user, null: false, foreign_key: true
      t.references :flashcard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
