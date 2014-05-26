class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
