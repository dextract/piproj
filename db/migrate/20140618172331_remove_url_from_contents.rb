class RemoveUrlFromContents < ActiveRecord::Migration
  def change
    remove_column :contents, :url
  end
end
