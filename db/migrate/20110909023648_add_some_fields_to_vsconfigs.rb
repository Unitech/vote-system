class AddSomeFieldsToVsconfigs < ActiveRecord::Migration
  def change
    add_column :vsconfigs, :editor_type, :string
    add_column :vsconfigs, :short_article, :boolean
  end
end
