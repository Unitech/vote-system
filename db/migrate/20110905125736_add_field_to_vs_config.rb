class AddFieldToVsConfig < ActiveRecord::Migration
  def change
    add_column :vsconfigs, :background_color, :string
    add_column :vsconfigs, :text_color, :string
    add_column :vsconfigs, :anonymous_comment, :boolean
  end
end
