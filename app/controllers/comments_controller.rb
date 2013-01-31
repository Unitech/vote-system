class CommentsController < ApplicationController

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  # def edit
  #   @comment = Comment.find(params[:id])
  # end

  # POST /comments
  # POST /comments.json
  def create
    # If user signed in, link comment to user
    if user_signed_in? 
      params[:comment][:user_id] = current_user.id
    else
      if @conf.anonymous_comment == false
        redirect_to request.referer, notice: t('You must be logged in to comment')
        return 
      end
      # Add http if not present (for anonymous)
      if !params[:comment][:anonymous_url].match /^http:\/\//i
        params[:comment][:anonymous_url].insert(0, "http://")
      end
    end
    
    # Persist flash variable
    flash[:old_back] = flash[:old_back]

    params[:comment][:content] = params[:comment][:content].gsub(/\n/, '<br>')
    
    @comment = Comment.new(params[:comment])
    
    if USER_REPUTATION == true and @conf.anonymous_comment == false
      article = Article.find(params[:comment][:article_id], :include => 'user')
      if current_user.id != article.user.id
        user = article.user
        user.reputation += REPUTATION_COMMENT
        user.save
      end
    end
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to request.referer, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  # def update
  #   @comment = Comment.find(params[:id])

  #   respond_to do |format|
  #     if @comment.update_attributes(params[:comment])
  #       format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
  #       format.json { head :ok }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /comments/1
  # DELETE /comments/1.json
  # def destroy
  #   @comment = Comment.find(params[:id])
  #   @comment.destroy

  #   respond_to do |format|
  #     format.html { redirect_to comments_url }
  #     format.json { head :ok }
  #   end
  # end
end
