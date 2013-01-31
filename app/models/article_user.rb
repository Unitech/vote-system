class ArticleUser < ActiveRecord::Base
  # Used for favourites + report articles
  belongs_to :user
  belongs_to :article

  validates_inclusion_of :relation_type, :in => [REPORT, FAVOURITE, VOTE]

  attr_accessible :relation_type, :user, :article
  # validates_uniqueness_of :user_id, scope => [:article_id]
end
