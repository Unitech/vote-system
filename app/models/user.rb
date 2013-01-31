class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  before_create :default_values

  serialize :friends_array

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable
  
  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :articles_users, :favourites, :site_url, :reputation, :friends_array, :confirmation_token, :confirmed_at

  has_many :articles
  has_many :comments
  # Favourite
  has_many :article_users

  
  def favourites
    array = Array.new
    self.article_users.where(:relation_type => FAVOURITE).includes(:article).each { |f| array.push f.article }
    return array
  end

  def count_posted
    return User.find_by_username(self.username).articles.count
  end
  
  def url
    return '/profil/' + self.username
  end


  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)

    data = access_token['extra']['user_hash']

    if user = User.where(:email => data["email"]).first
      user
    else # Create a user with a stub password. 
      u = User.create(:username => data["first_name"] + '.' + data["last_name"], :email => data["email"], :password => Devise.friendly_token[0,20]) 
      # It do the tricks, AVOID FUCKING SHIT CONFIRMATION OF BITCH
      u.update_attributes(:confirmation_token => nil, :confirmed_at => Time.now)
      u
    end
  end

  def self.new_with_session(params, session)
    
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end
  
  protected

  def default_values
    self.reputation = 0
  end

  # Username or mail identification with devise
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
end
