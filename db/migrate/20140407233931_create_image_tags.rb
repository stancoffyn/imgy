class CreateImageTags < ActiveRecord::Migration
  def change
    drop_table :images_tags

    create_table :image_tags do |t|
      t.belongs_to :image
      t.belongs_to :tag
      t.timestamps
    end
  end
end
