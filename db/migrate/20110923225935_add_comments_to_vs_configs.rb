class AddCommentsToVsConfigs < ActiveRecord::Migration
  def change
    add_column :vsconfigs, :comment_table_name, :string
  end
end
