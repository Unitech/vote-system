class AddFieldsToVsConfigs < ActiveRecord::Migration
  def change
    add_column :vsconfigs, :private,    :boolean
  end
end
