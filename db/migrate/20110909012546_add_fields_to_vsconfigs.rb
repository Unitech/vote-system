class AddFieldsToVsconfigs < ActiveRecord::Migration
  def change
    add_column :vsconfigs, :locale, :string
    add_column :vsconfigs, :display_title, :boolean
  end
end
