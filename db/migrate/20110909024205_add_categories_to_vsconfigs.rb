class AddCategoriesToVsconfigs < ActiveRecord::Migration
  def change
    add_column :vsconfigs, :categories, :string
  end
end
