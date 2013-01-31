class Article < ActiveRecord::Base
  # Middleware
  before_save :default_attr

  ARTICLE_TYPE = ['plugin', 'shortcut', 'configuration', 'other']
  # If we need something specific for search autocomplete
  # def post_url
  #   "<a href='/show/#{self.id}'>#{self.title}</a>"
  # end

  #
  #
  # Helper (need convention like article_path(@article)
  #
  def url_article
    return '/show/' + self.id.to_s + '/' + URI.escape(self.title.to_s)
  end

  def url_edit_article
    return '/edit/' + self.id.to_s + '/' + URI.escape(self.title.to_s)
  end
    
  def reported_time
    return self.article_users.where(:relation_type => REPORT).count
  end

  def favourited_time
    return self.article_users.where(:relation_type => FAVOURITE).count
  end
    
  # Association
  belongs_to :user
  has_many :comments

  # Favourite
  has_many :article_users

  validates_presence_of :title
  validates_length_of :title, :within => 2..160
  validates :description, :presence => true, :length => {:maximum => 1000}
  validates :categorie, :presence => true
  validates :username, :presence => true

  protected
  def default_attr
    # self.username = current_user.username
    self.like_nb ||= 0
    self.dislike_nb ||= 0
  end
end
