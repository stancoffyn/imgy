class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.integer :type, default: 0
      t.string :source_url

      t.timestamps
    end
  end
end
