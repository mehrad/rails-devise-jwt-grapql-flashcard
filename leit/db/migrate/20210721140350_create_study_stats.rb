class CreateStudyStats < ActiveRecord::Migration[6.1]
  def change
    create_table :study_stats do |t|
      t.jsonb :log, null: false, default: {}
      t.references :studycard, null: false, foreign_key: true
    end
  end
end
