class CreateVisuals < ActiveRecord::Migration
  def change
    create_table :visuals do |t|
      t.string :type
      t.string :youtube_id
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
