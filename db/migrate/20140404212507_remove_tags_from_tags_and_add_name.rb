class RemoveTagsFromTagsAndAddName < ActiveRecord::Migration
  def change
    remove_column :tags, :tags, :string
    add_column :tags, :name, :string
  end
end
