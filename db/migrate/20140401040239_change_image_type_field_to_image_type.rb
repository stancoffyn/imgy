class ChangeImageTypeFieldToImageType < ActiveRecord::Migration
  def change
    remove_column :images, :type
    add_column :images, :image_type, :string
  end
end
