class CreateVisualUtilizations < ActiveRecord::Migration
  def change
    create_table :visual_utilizations do |t|
      t.integer :content_id
      t.integer :visual_id
      t.string :visualType
      t.string :visualSize
      t.timestamps
    end
  end
end
