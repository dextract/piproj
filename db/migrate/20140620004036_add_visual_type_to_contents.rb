class AddVisualTypeToContents < ActiveRecord::Migration
  def change
    add_column :contents, :visualType, :string
  end
end
