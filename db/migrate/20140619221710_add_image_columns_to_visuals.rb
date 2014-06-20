class AddImageColumnsToVisuals < ActiveRecord::Migration
  def self.up
    add_attachment :visuals, :image
  end

  def self.down
    remove_attachment :visuals, :image
  end
end
