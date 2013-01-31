class ProfilController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    if @user.nil?
      render 'unknown'
      return
    end
    @articles = Article.paginate :page => params[:page], :per_page => ARTICLE_TO_DISPLAY, :conditions => ['user_id = ?', @user.id], :include => 'comments', :order => 'created_at DESC'
  end
end
