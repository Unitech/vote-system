class AddTypeToArticleUsers < ActiveRecord::Migration
  def change
    add_column :article_users, :relation_type, :string
  end
end
