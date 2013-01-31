class ApplicationController < ActionController::Base
  include UrlHelper
  before_filter :load_site_configuration

  protect_from_forgery
  protected
  def load_site_configuration
    @conf = Vsconfig.find_by_subdomain(request.subdomain)
    # The subdomain exist ?
    if @conf.nil?
      # The actual url is the home url ?
      # print 'a'*99, request.subdomain
      if request.subdomain.empty? == false
        # Redirect to home URL
        redirect_to root_url(:subdomain => false)
      end
    else
      # Change table name to hit
      Article.set_table_name(@conf.articles_table_name)
      Comment.set_table_name(@conf.comments_table_name)

      # Langue
      unless @conf.locale == 'default'
        I18n.locale = @conf.locale
      end
    end
  end

  def get_right_data
   @hot_this_week = Article.where(['created_at >= ?', Date.today - 14]).limit(8).order('(like_nb - dislike_nb) DESC')
   @best_ever = Article.limit(8).order('(like_nb - dislike_nb) DESC')

  end
end
