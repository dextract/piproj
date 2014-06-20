class AddDetailsToContents < ActiveRecord::Migration
  def change
    add_column :contents, :name, :string
    add_column :contents, :organization, :string
    add_column :contents, :time, :time
    add_column :contents, :beginDate, :time
    add_column :contents, :endDate, :time
    add_column :contents, :local, :string
    add_column :contents, :visualType, :string
    add_column :contents, :visual_id, :integer
    add_column :contents, :visualSize, :string
  end
end
