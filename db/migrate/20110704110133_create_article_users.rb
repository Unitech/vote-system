class CreateArticleUsers < ActiveRecord::Migration
  def change
    create_table :article_users do |t|
      t.references :user
      t.references :article
      t.timestamps
    end
  end
end
