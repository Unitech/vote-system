class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string 'title'
      t.string 'content'
      t.references 'article'
      t.references 'user'
      t.string 'anonymous_url'
      t.string 'anonymous_nick'
      t.timestamps
    end
  end
end
