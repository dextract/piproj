class ChangeTimeToDateContents < ActiveRecord::Migration
  def change
    remove_column :contents, :beginDate
    remove_column :contents, :endDate
    add_column :contents, :beginDate, :date
    add_column :contents, :endDate, :date
  end
end
