class CorrectHasManyAssociation < ActiveRecord::Migration
  def change
    drop_table :images_tags

    create_table :images_tags do |t|
      t.belongs_to :image
      t.belongs_to :tag
    end
  end
end
