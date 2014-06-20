class RemoveVisualTypeFromContents < ActiveRecord::Migration
  def change
    remove_column :contents, :visualType
    remove_column :contents, :visual_id
    remove_column :contents, :visualSize
  end
end
