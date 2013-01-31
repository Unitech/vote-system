class Vsconfig < ActiveRecord::Base

  has_attached_file :image, :styles => { :thumb => "75x75" }

  validates_presence_of :title
  validates_uniqueness_of :title

  validates_presence_of :table_name
  validates_uniqueness_of :table_name
  
  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain

  validates_presence_of :resume

  def articles_table_name
    self.table_name
  end

  def comments_table_name
    self.table_name + '_comments'
  end

  def create_table
    #
    # Create new table for comments
    #
    ActiveRecord::Schema.create_table self.comments_table_name do |t|
      t.string   "title"
      t.string   "content"
      t.integer  "article_id"
      t.integer  "user_id"
      t.string   "anonymous_url"
      t.string   "anonymous_nick"
      t.datetime "created_at"
      t.datetime "updated_at"
    end


    #
    # Create new table for the new VS
    #
    ActiveRecord::Schema.create_table self.table_name do |t|
      t.string   "title"
      t.text     "description"
      t.string   "link"
      t.text     "tags"
      t.integer  "like_nb"
      t.integer  "dislike_nb"
      t.boolean  "approved"
      t.string   "categorie"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "username"
    end

  end
end
