class UtilsController < ApplicationController
  #
  # All feed
  # 
  def feed
    @articles = Article.all(:select => "title, id, description, created_at", :order => 'created_at DESC', :limit => 20)
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
    render 'utils/rss'
    return 
  end

  #
  # Best feed
  #
  def best
    @articles = Article.where("like_nb >= 10").order("created_at DESC").limit(20)
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
    render 'utils/rss'
    return 
  end


end
