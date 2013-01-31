class AddImageToVsconfigs < ActiveRecord::Migration
  def change
    add_column :vsconfigs, :image_file_name,    :string
    add_column :vsconfigs, :image_content_type, :string
    add_column :vsconfigs, :image_file_size,    :integer
    add_column :vsconfigs, :image_updated_at,   :datetime
  end
end

