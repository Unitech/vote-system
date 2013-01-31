Votesystem::Application.routes.draw do
  
  resources :vsconfigs

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  
  resources :comments

  
  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  match '/auth/:provider/callback' => 'sessions#create'


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }
  #
  # Home controller
  #
  match "more_posts", :to => 'ajax_load#more_posts', :as => :ajax_get
  match "hottest", :to => 'home#hottest', :as => :hottest
  match "best", :to => 'home#best', :as => :best

  match "about", :to => 'misc#about', :as => :about

  match "tag/:tag_name", :to => 'home#tag', :as => :by_tag
  match "tag", :to => redirect("/"), :as => :by_tag

  match "by/:username", :to => 'home#by', :as => :by_person, :constraints => { :username => /[0-z\.]+/ }
  match "by", :to => redirect("/"), :as => :by_person

  match "show/:id/:name", :to => 'home#show', :as => :show_article, :constraint => { :name => /[0-9A-Za-z\-\.]+/ }
  match "show", :to => redirect("/"), :as => :show_article

  match "favourites", :to => 'home#favourite', :as => :favourite_articles

  #
  # Special pages
  #
  match "best_weeks", :to => 'special_pages#best_weeks', :as => :best_weeks

  #
  # Ajax load controller
  #
  match "vote_up", :to => 'ajax_load#vote_up', :as => :vote_up
  match "vote_down", :to => 'ajax_load#vote_down', :as => :vote_down

  match "report", :to => 'ajax_load#report_article', :as => :report_article

  match "setFavourite", :to => 'ajax_load#favourite', :as => :set_favourite
  get "test", :to => 'ajax_load#autocomplete_article_title', :as => :autocomplete

  match "get_comments", :to => 'ajax_load#get_comments', :as => :get_comments
  post "ajax_comment", :to => 'ajax_load#comment', :as => :ajax_comment

  post "add_as_friend", :to => 'ajax_load#add_as_friend', :as => :one_add_as_friend

  #
  # Article controller
  #
  match "new", :to => 'article#new', :as => :new_article
  match "article/create", :to => 'article#create', :as => :create_article
  match "edit/:id/:name", :to => 'article#edit', :as => :edit_article, :constraint => { :name => /[0-9A-Za-z\-\.]+/ }
  match "update", :to => 'article#update', :as => :update_article
  #
  # Utils (RSS & co)
  #
  scope :path => '/feed', :controller => :utils do
    get "all" => :feed, :defaults => { :format => 'rss' }, :as => :all_feed
    get "best" => :best, :defaults => { :format => 'rss' }, :as => :best_feed
  end


  #
  # Profil
  #
  scope :path => '/profil', :controller => :profil, :as => :profil do
    get ":username" => :show, :constraints => { :username => /[0-z\.]+/ }, :as => :show
  end

  constraints(Subdomain) do
    match '/' => 'home#index'
  end

  get '/index', :to => 'vsconfigs#index'
  # Catch tous les sousdomaines si non existant
  root :to => 'vsconfigs#vs'

end
