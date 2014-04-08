class AddNameToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tags, :string
  end
end
