class SpecialPagesController < ApplicationController
  layout 'application_noctua'
  before_filter :get_right_data

  def best_weeks
    @title_page = "Best each week"
    @categorie =__method__

    date_act = Date.today
    i = 0
    @best = {}
    while date_act > Date.parse(@conf.date_begin.time.strftime('%Y/%m/%d'))
    
      @best[i] = {}
      query = Article.where('created_at >= ? and created_at <= ?', date_act - 7, date_act).order('(like_nb - dislike_nb) DESC').limit(5)
      if query.length >= 4
        @best[i] = {"data" => query, "from" => date_act - 7, "to" => date_act}
      end
      i += 1
      date_act = date_act - 7
    end

    @articles = Article.paginate :page => params[:page], :per_page => ARTICLE_TO_DISPLAY, :order => 'created_at DESC', :include => 'comments'
  end
  


end
