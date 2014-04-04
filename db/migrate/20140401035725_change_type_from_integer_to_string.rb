class ChangeTypeFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :images, :type, :string
  end
end
