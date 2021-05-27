class ChangeLastStudiedAtAndHouseDefaultsInStudyCards < ActiveRecord::Migration[6.1]
  def change
    change_column_default :studycards, :last_studied_at, Time.now
    change_column_default :studycards, :house, 0
  end
end
