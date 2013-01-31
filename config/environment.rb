# Load the rails application
require File.expand_path('../application', __FILE__)

# Application name
APPLICATION_NAME = 'Emacs VS'
TITLE_HTML = 'Compare all stuff related to Emacs'

ADVERTISEMENT = true

# For cookies
ID_HV = 'vs1'

# Date

DATE_BEGIN = Date.new(2011, 8, 14)
DATE_FORMAT = "%d/%m/%y"

# Application configuration
AJAX_LOAD = true
ANONYMOUS_VOTE = true
ANONYMOUS_COMMENT = false
USER_REPUTATION = true

# Value for one comment more
REPUTATION_COMMENT = 1
# Value for one vote more
REPUTATION_POSITIVE_VOTE = 1
# Value for one less vote
REPUTATION_NEGATIVE_VOTE = -1

ARTICLE_TO_DISPLAY = 10
FAVOURITE = 'favourite'
REPORT = 'report'
VOTE = 'vote'

HEAT_INDICATOR = false

RIGHT_SIDE = false

MARKDOWN_ARTICLE = true

SOCKET_IO = false

TWITTER_STATUS = true




# Initialize the rails application
Votesystem::Application.initialize!

