class RemoveUserFromStudycards < ActiveRecord::Migration[6.1]
  def change
    change_table :studycards do |t|
      t.remove_references :user
    end
  end
end
