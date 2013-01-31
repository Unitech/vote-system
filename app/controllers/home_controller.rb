
require 'will_paginate/array'

class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => 'favourite'
  before_filter :get_right_data
  layout 'application_noctua'

  #
  # Home page
  #
  def index
    @index = true
    @title_page = "Last posts"
    @categorie =__method__
    @articles = Article.paginate :page => params[:page], :per_page => ARTICLE_TO_DISPLAY, :order => 'created_at DESC', :include => 'comments'
  end

  #
  # Hottest for this week
  #
  def hottest
    @title_page = "Hot posts this week"
    @categorie =__method__
    @articles = Article.paginate :page => params[:page], :per_page => ARTICLE_TO_DISPLAY, :order => '(like_nb - dislike_nb) DESC', :conditions => ['created_at >= ?', Date.today - 7], :include => 'comments'
    render 'home/multiple_article'
  end
  
  #
  # Best of all
  #
  def best
    @title_page = "All-time greats"
    @categorie =__method__
    @articles = Article.paginate :page => params[:page], :per_page => ARTICLE_TO_DISPLAY, :order => '(like_nb - dislike_nb) DESC', :include => 'comments'
    render 'home/multiple_article'
  end
  
  #
  # Favourites article
  #
  def favourite
    @title_page = "My favourite posts"
    @articles = current_user.favourites.paginate :page => params[:page], :per_page => ARTICLE_TO_DISPLAY, :order => 'created_at ASC', :include => 'comments'
    
    render 'home/multiple_article'
  end

  #
  # Show an article
  #
  def show
    # For redirecting if he posts a comment
    if flash[:old_back].nil?
      flash[:old_back] = request.referer
    end

    @article = Article.first(:conditions => {:id => params[:id]}, :include => [:comments => :user], :order => 'created_at DESC')
    if @article.nil?
      render 'article/unknown'
      return 
    end
    # @comments = @article.comments.order('created_at ASC').includes(:user)
    @comments = @article.comments
    @comment = Comment.new
    @title_page = @article.title + " post"
    render 'home/alone_article'
  end


  #
  # Search by person
  #
  def by
    # security failure (possible XSS)
    @title_page = "Posts from #{params[:username]}
                   <div style='font-size : 12px;'>(Profil : <a href='/profil/#{params[:username]}'>#{params[:username]}                  </a>)</div>"
    
    user = User.first(:conditions => {:username => params[:username]}, :select => 'id')
    @articles = Article.paginate :page => params[:page], :per_page => ARTICLE_TO_DISPLAY, :conditions => ['user_id = ?', user.id], :include => 'comments', :order => 'created_at DESC'

    render 'home/multiple_article'
  end

  #
  # Search by tag
  #
  def tag
    @title_page = 'All commands tagged with ' + params[:tag_name]
    @articles = Article.paginate :page => params[:page], :per_page => ARTICLE_TO_DISPLAY, :order => 'created_at DESC', :conditions => ['tags like ? or categorie = ?', '%' + params[:tag_name] + '%', params[:tag_name]], :include => 'comments'
   render 'home/multiple_article'
  end

end
