class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :link
      t.text :tags

      t.integer :like_nb
      t.integer :dislike_nb
      
      t.boolean :approved
      
      t.string :categorie
      
      t.references :user
      t.timestamps
    end
    add_index :articles, [:user_id]
  end
end
