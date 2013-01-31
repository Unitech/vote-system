class AjaxLoadController < ApplicationController
  autocomplete :article, :title #, :display_value => :post_url

  before_filter :before_vote, :only => ['vote_up', 'vote_down']

  def more_posts
    if AJAX_LOAD == false
      render :json => {:success => false, :info => 'No ajax load on this site'}
      return 
    end

    if params[:categorie] == 'index'
      @articles = 
        Article.offset(Integer(params[:offset])).limit(ARTICLE_TO_DISPLAY).order('created_at DESC').includes(:comments)
    elsif params[:categorie] == 'hottest'
      @articles = 
        Article.offset(Integer(params[:offset])).limit(ARTICLE_TO_DISPLAY).order('(like_nb - dislike_nb) DESC').where('created_at >= ?', Date.today - 7).includes(:comments)
    else
      @articles = 
        Article.offset(Integer(params[:offset])).limit(ARTICLE_TO_DISPLAY).order('(like_nb - dislike_nb) DESC').includes(:comments)
    end

    if @articles.length > 0
      render :partial => 'shared/article', :locals => {:articles => @articles }
    else
      render :json => {:success => false}
    end
  end

  def vote_up
    # There is an before filter at top
    
    if USER_REPUTATION == true and (user_signed_in? == true and current_user.id != @article.user.id)
      user = @article.user
      user.reputation += REPUTATION_POSITIVE_VOTE
      user.save
    end

    if ANONYMOUS_VOTE == false and user_signed_in? == true
      if ArticleUser.exists?(:user_id => current_user.id, :article_id => @article.id, :relation_type => VOTE) == false
        favourite = ArticleUser.create(:user => current_user, :article => @article, :relation_type => VOTE)
        @article.like_nb += 1
        @article.save
        render :json => { :success => true, :votes => @article.like_nb - @article.dislike_nb, :info => 'You voted !'}
        return 
      else
        render :json => {:success => false, :info => 'You already voted (SS)'}
        return 
      end
    end
    
    # Anonymous vote
    @article.like_nb += 1
    @article.save
    render :json => { :success => true, :votes => @article.like_nb - @article.dislike_nb, :info => 'You voted !' }
    return 
  end

  def vote_down
    # There is an before filter at top

    if USER_REPUTATION == true and (user_signed_in? == true and current_user.id != @article.user.id)
      user = @article.user
      user.reputation += REPUTATION_NEGATIVE_VOTE
      user.save
    end

    if ANONYMOUS_VOTE == false and user_signed_in? == true
      if ArticleUser.exists?(:user_id => current_user.id, :article_id => @article.id, :relation_type => VOTE) == false
        favourite = ArticleUser.create(:user => current_user, :article => @article, :relation_type => VOTE)
        @article.dislike_nb += 1
        @article.save
        render :json => { :success => true, :votes => @article.like_nb - @article.dislike_nb, :info => 'You voted !'}
        return 
      else
        render :json => {:success => false, :info => 'You already voted (SS)'}
        return 
      end
    end
    
    @article.dislike_nb += 1
    @article.save
    render :json => {:success => true, :votes => @article.like_nb - @article.dislike_nb, :info => 'You voted !' }
    return 
  end
  
  def favourite
    article = Article.find_by_id(params[:id])
    if article.nil? or user_signed_in? == false
      render :json => {:success => false, :info => 'You must be logged in'}
      return 
    end

    if ArticleUser.exists?(:user_id => current_user.id, :article_id => article.id, :relation_type => FAVOURITE) == false
      favourite = ArticleUser.create(:user => current_user, :article => article, :relation_type => FAVOURITE)
      render :json => {:success => true}
    else
      render :json => {:success => false, :info => 'Already in your favourite'}
    end
  end


  def get_comments 
    # Optimization TODO
    @article = Article.find(params[:id], :include => :comments)
    @comments = @article.comments.limit(5).includes(:user)

    # @comments = Comment.where(:article_id => params[:id]).includes(:user).limit(10)

    #render :json => {:success => true, :comments => @comments}
    data = render_to_string(:partial => 'shared/comments', :locals => {:comments => @comments})
    # create button client side if more than 5 comments
    max_button = @comments.length == 5 ? 'max' : 'min'
    render :json => {:success => true, :data => data, :count => max_button, :for_more_url => @article.url_article}
  end

  def report_article
    article = Article.find_by_id(params[:id])
    if article.nil? or user_signed_in? == false
      render :json => {:success => false, :info => 'You must be logged in'}
      return 
    end
    
    if ArticleUser.exists?(:user_id => current_user.id, :article_id => article.id, :relation_type => REPORT) == false
      favourite = ArticleUser.create(:user => current_user, :article => article, :relation_type => REPORT)
      render :json => {:success => true}
    else
      render :json => {:success => false, :info => 'Already reported'}
    end
  end

  def add_as_friend
    if User.exists?(:id => params[:id]) == false or user_signed_in? == false
      render :json => {:success => false, :info => 'You must be logged in'}
      return
    end
    
    data = current_user.friends_array

    if data.nil?
      data = []
    end

    if data.include?(params[:id]) == true
      render :json => {:success => false, :info => 'Already added as friend'}
      return 
    end

    data << params[:id]
    current_user.update_attributes(:friends_array => data)

    render :json => {:success => true}
    return
  end

  protected
  def before_vote
    @article = Article.find(params[:id])

    if @article.nil? 
      render :json => {:success => false, :info => 'Weird error : Article unknown'}
      return 
    end

    if ANONYMOUS_VOTE == false and user_signed_in? == false
      render :json => {:success => false, :info => 'You must be logged in'}
      return 
    end

  end

end
