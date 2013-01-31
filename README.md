# NoctuaGUI

## environment.rb

    # Allow Wall stream on main page
    AJAX_LOAD = true
    # Allow non registred user to vote 
    ANONYMOUS_VOTE = false
    # Allow non registred user to comment
    ANONYMOUS_COMMENT = false

## Database

Article has a special field, `username` which is the username of the User who posted the article. It's to avoid useless request.


# Help 

## Fb

{"id"=>"581945270", "name"=>"Alexandre Strzelewicz", "first_name"=>"Alexandre", "last_name"=>"Strzelewicz", "link"=>"http://www.facebook.com/alexandre.strzelewicz", "username"=>"alexandre.strzelewicz", "location"=>{"id"=>"110774245616525", "name"=>"Paris, France"}, "gender"=>"male", "email"=>"alexnext@hotmail.fr", "timezone"=>2, "locale"=>"en_US", "verified"=>true, "updated_time"=>"2011-07-12T17:31:21+0000"}

# Specifics 


## article.rb

  def url_article
    return 'http://localhost:3000/show/' + self.title.to_s
  end

Used in _article_internal.html.erb and rss.rss.builder

## Autocomple

Automcomplete Jquery plugin modified (separated with the jquery ui)


## user.rb

  def url
    return 'http://localhost:3000/by/' + self.username
  end
