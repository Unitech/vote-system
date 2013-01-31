require "twitter"
require "bitly"

class ArticleController < ApplicationController
  PUBLIC_PAGES  = ['by', 'tag']
  before_filter :authenticate_user!, :except => PUBLIC_PAGES

  layout 'application_noctua', :only => PUBLIC_PAGES
  layout 'application', :except => PUBLIC_PAGES

  #
  # New article
  #
  def new
    @article = Article.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    # if MARKDOWN_ARTICLE == false
    #   params[:article][:description] = params[:article][:description].gsub(/\n/, '<br>')
    # end

    @article = Article.new(params[:article])
    @article.user = current_user
    @article.username = current_user.username

    if @article.save

      if SOCKET_IO == true
        # Contact node.js
        test = render_to_string :partial => 'shared/article_internal', :locals => {:article =>  @article}
        test = test.gsub("\n", '').gsub('"', '\'')      
        cmd = "curl -d \"content=" + test + "\" http://localhost:8001/";      
        system(cmd)
      end

      if TWITTER_STATUS == true and Rails.env.production? == true
        bitly = Bitly.new('o_1fc9t1rmlo','R_ec309bcc58ccc92ce1fe746c7d7d6819')
        page_url = bitly.shorten('http://' + request.host + @article.url_article)
        #page_url = bitly.shorten("http://hemca.com")
        tweet = page_url.shorten + ' - ' + @article.title + ' (by ' + current_user.username + ')'
        Twitter.update(tweet)
      end

      
      flash[:notice] = 'Article successfully posted'
      redirect_to root_path
      return 
    end
    respond_to do |format|
      format.html { render action: "new" }
    end
  end

  def edit
    @article = Article.first(:conditions => {:id => params[:id]})
  end

  def update
    @article = Article.find(params[:article][:id])

    if @article.user.id != current_user.id
      print 'shut'*99
      redirect_to :root
      return
    end

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article.url_article, notice: 'Article was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

end
