
function fusion(el, time) {
    el.fadeIn(time).fadeOut(time + 1500);
    this.break_wallpaper = setInterval(function() {
	el.fadeOut(time + 500).fadeIn(time + 500);
    }, time);
}

function NoctuaGUI(cat, id, ads) {

    this.id = id;
    this.cat = cat || 'specific_page';
    this.ads = ads || false;
    
    this.offset = 10;
    this.nb_art = this.offset;
    
    this.mobile = undefined;

    // Caching
    this.dom_articles = $('#articles');

    // Init all
    this.detectMobile();
    this.handleEvents();
    this.handleSearch();
    //this.initChat();
    this.recalculateSize();

    
    // To stop top bar resynchronize
    this.end_follow = false;
     
    this.handleLikeSystem();

    
    // animation
    
    
    //if (this.cat == 'index') {
	$('#indicate-menu').click(function() {

	    $('.page-outer, .descr').animate({'opacity':'0.1'}, function() {
		$('#followbar').animate({'top':150}, 350);
		$('body').click(function() {
		    $(this).unbind('click');
		    $('#followbar').animate({'top': '0'}, 250,  function() {
			$('.page-outer, .descr').animate({'opacity':'1'});
		    });
		    
		});
	    });
	});
//}
    // 	$('.site-descr').animate({'width' : '300'}, function() {
    // 	    $(this).find('.text').fadeIn();
    // 	});
    // 	$('.site-descr-left').animate({'width' : '300'}, function() {
    // 	    $(this).find('.text').fadeIn();
    // 	});
    // }
    fusion($('.pagination').find('.current'), 1500);
}

NoctuaGUI.prototype.handleSearch = function() {
    set_auto_text($('#searchbar'), 'Search... ');
}

NoctuaGUI.prototype.detectMobile = function() {
    if (navigator.userAgent.match(/Android/i) ||
	navigator.userAgent.match(/webOS/i) ||
	navigator.userAgent.match(/iPhone/i) ||
	navigator.userAgent.match(/iPod/i)) {
	// JQuery Scroll doesnt work with mobile, so fix directly the followbar
	$('#followbar').css({'position': 'fixed'});
	this.mobile = true;
    }
    else {
	this.mobile = false;
	// Activate Wall Stream if not mobile
	this.getMoreArticles();
    }
}

NoctuaGUI.prototype.recalculateSize = function() {
    var width_left;
    var wrap = $('#wrapper');

    // if (wrap.outerWidth() < 1200) {
    // 	$('#rightside', wrap).hide();
    // 	width_left = wrap.outerWidth() - 10;
    // }
    // else {
    // 	$('#rightside', wrap).show();
    // 	if (this.mobile == false)
    // 	    width_left = wrap.outerWidth() - $('#rightside', wrap).outerWidth() - 20;
    // 	else
    // 	    width_left = wrap.outerWidth();
    // }

    // $('#leftside', wrap).css({
    // 	'width' : width_left
    // });
    // $('#searchbar', wrap).css({
    // 	'width' : width_left - 8
    // });    
}

NoctuaGUI.prototype.isStreamedPage = function() {
    if (this.cat == 'index' || this.cat == 'hottest' || this.cat == 'best')
	return true;
    return false;
}

/***************** Streamed wall ***************/

NoctuaGUI.prototype.getMoreArticles = function() {
    this.newFlag = 0;
    var wait = $('<div id="processing"><center>' + images_rev.loadingwait + '</center></div>');
    var self = this;
    var $win = $(window);
    

    if (this.isStreamedPage() == false) {
	return false;
    }

    $(window).scroll(function() {

	self.specialAlertFollow($win);
	// Streamed wall
	if ($win.height() + $win.scrollTop() > $(document).height() - 300 &&
	    self.newFlag == 0) {
	    self.newFlag = 1;
	    var xhr = $.ajax({
		type : "POST",
		url : ajaxUrls.moreArticles,
		data : {
		    'offset' : self.offset,
		    'categorie' : self.cat,
		    'authenticity_token' : _token
		},
		beforeSend : function() {
		    // Click on wait = cancel ajax
		    wait.click(function(){
			xhr.abort();
		    });
		    // Add loading image
		    self.dom_articles.append(wait);
		},
		success : function(data) {
		    if (data.success == false) {
			// Unbind scrolling when no more articles
			$(window).unbind('scroll');
			$('#articles').append('<div class="adv end-message" alt="0" done="1" style="height : 35px; padding-top : 20px;">No more article. <a href="/users/sign_up" target="_blank">Register</a> (or with facebook <a href="/users/auth/facebook"><img src="/assets/login/login_fb.png"></a>) and <a href="/new" target="_blank">share you knowledge</a> !</div>');
			return ;
		    }
		    // Remove pagination at bottom
		    $('.pagination-bottom').remove();
		    // Avoid double loading
		    self.newFlag = 0;
		    // Add offset for further loading
		    self.offset += self.nb_art;
		    // Append received data
		    
		    var data_adv;
		    
		    if (self.ads == false) {
			data_adv = '<div class="adv" alt="0000" done="1">Posts ' + (self.offset - self.nb_art) + ' -> ' + self.offset + '</div>';  
		    }
		    else {
			data_adv = $('#adve-1').html();
		    }

		    $('#articles').append(data_adv).append(data);
		    // Launch refresh on new data
		    self.handleLikeSystem();
		},
		complete : function() {
		    wait.remove();
		}
	    });
        }
    });
}

NoctuaGUI.prototype.handleEvents = function() {
    var self = this;

    $(window).resize(function() {
	self.recalculateSize();
    });
}


// A refaire si besoin de la functionalité
NoctuaGUI.prototype.specialAlertFollow = function($win) {
    // To make the followbar following the navigator
    if (self.mobile == false && self.end_follow == false && $win.scrollTop() > 50) {
	$('#followbar').css({'height' : '0'})
	    .css({'position': 'fixed', 'top' : '60px'})
	    .animate({'height' : '28', 'top' : '0px'}, 400, function() {});
	self.end_follow = true;
    }
}


/***************** Like System ***************/

NoctuaGUI.prototype.handleLikeSystem = function () {
    //cookie.deleteCookie('lbk');
    this.data = cookie.get_values(this.id);
    var data = this.data;
    var self = this;

    // Faire un indexOf pour plus d'optis
    $('.art', '#articles').each(function() {
	var done = $(this).attr('done');
	var article_id = $(this).attr('alt');
	var article = $(this);
        if (done == "0") {
            if (data != null) {
		if (data.indexOf(article_id) > -1) {
		    $(this).find('#votes')
			.css({'opacity':'0.5', 'z-index':'-20'});
		    article.attr('voted', '1');
		}
            }
	    
	    // ---> Split tags <----
	    var dom_tmp = article.find('.content-tags');
	    var tmp = dom_tmp.html().split(',');
	    dom_tmp.html('');

	    for (var i = 0; i < tmp.length; i++) {
		if ($.trim(tmp[i]) != '')
		    dom_tmp.append("<a href='/tag/" + 
				   $.trim(tmp[i]) + 
				   "'>" + 
				   $.trim(tmp[i]) + 
				   "</a> ");
	    }
	    
	    // ---> Bind onclick events <---
	    // dom_tmp.find("#sb-comments").click(self.showComments(article.attr('alt')));
	    // article.find('#heat-indicator').heatcolor({
	    // 	displayText : true,
	    // 	caractersToAdd : '°F',
	    // 	valueCss : 'font-weight : bold; padding-left : 5px;'
	    // });
	    
	    // Bind report button
	    article.find('#report').click(function() {
		noctuaGUI.reportArticle($(this), article_id);
	    });
	    
	}
        $(this).attr('done', '1');
    });
}

NoctuaGUI.prototype.changeVote = function(id, voteNb) {
    $('#nbvotes' + id, '#articles')
	.html(voteNb)
	.parent()
	.css({'opacity':'0.5', 'z-index':'-20'});
}

NoctuaGUI.prototype.checkVote = function(id) {

    // Faster than to go through DOM
    if (!this.data) return ;

    for (var i = 0; i < this.data.length; i++) {
        if (id == this.data[i]) {
	    notify('You have already voted');
	    return 1;
        }
    }
    return 0;
}

NoctuaGUI.prototype.voteUp = function (id) {    
    var self = this;
    
    if (this.checkVote(id) == 1)
	return ;
    
    var ele = $('#nbvotes' + id, '#articles');
    var v = parseInt(ele.html());

    $.ajax({
	type : "POST",
	url : ajaxUrls.voteUp,
	data : {
	    'id' : id,
	    'authenticity_token' : _token
	},
	beforeSend : function() {
	    ele.html(v + 1);
	},
	success : function(data) {
	    if (data.success == true) {
		// on ajoute la val dans le cookie
		cookie.push_val(self.id, id);
		// on change le nb de votes
		self.changeVote(id, data.votes);
		// on relis le cookie entierement (moche)
		self.data = cookie.get_values(self.id);
		notify(data.info);
	    }
	    else {
		notify(data.info);
		ele.html(v);
	    }
	}
    });
}

NoctuaGUI.prototype.voteDown = function (id) {
    var self = this;
    if (this.checkVote(id) == 1)
	return ;

    var ele = $('#nbvotes' + id, '#articles');
    var v = parseInt(ele.html());

    $.ajax({
	type : "POST",
	url : ajaxUrls.voteDown,
	data : {
	    'id' : id,
	    'authenticity_token' : _token
	},
	beforeSend : function() {
	    ele.html(v - 1);
	},
	success : function(data) {
	    if (data.success == true) {
		cookie.push_val(self.id, id);
		self.changeVote(id, data.votes);
		self.data = cookie.get_values(self.id);
		notify(data.info);
	    }
	    else {
		ele.html(v);
		notify(data.info);
	    }
	}
    });
}

/********** Favourites ***********/

NoctuaGUI.prototype.addFavourite = function(id) {
    $.ajax({
	type : "POST",
	url : ajaxUrls.favourite,
	data : {
	    'id' : id,
	    'authenticity_token' : _token
	},
	success : function(data) {
	    if (data.success == true) 
		notify('Successfully added to your favourites');
	    else
		notify(data.info);
	}
    });   
}

/***************** Chat ***************/

NoctuaGUI.prototype.initChat = function() {
    var chat_collapsed = function(el) {
	$(el)
	    .stop()
	    .html('Chat')
	    .addClass('chatcollapsed').removeClass('chattoggled')
	    .attr('collapsed', 'true')
	    .animate({
		'height':'25px'
	    });
    }

    $('#chat').click(function() {
	if ($(this).attr('collapsed') == 'true') {
	    
	    $(this)
		.stop()
		.addClass('chattoggled').removeClass('chatcollapsed')
		.attr('collapsed', 'false')
		.animate({
		    'height':'350px'
		});
	}
	else
	    chat_collapsed($(this));
    });
    // Init chat
    chat_collapsed($('#chat'));
}


/************* Report *************/

// Un bug qui traine, TODO a corriger
NoctuaGUI.prototype.reportArticle = function (el2, id) {
    var el = find_article_by_id(id);
    var data = $('<span>Are you sure ? <span id="yes">yes</span> / <span id="nop">no</span></span>');
    var old = el.find('#report').html();
    
    
    function restore(el) {
	var dt = el.find('#report');
	dt.html(old);
	// dt.click(function() {
	//     noctuaGUI.reportArticle(id);
	// });	
    }

    data.find('#yes').click(function() {    
	$.ajax({
	    type : "POST",
	    url : ajaxUrls.reportArticle,
	    data : {
		'id' : id,
		'authenticity_token' : _token
	    },
	    success : function(data) {
    		restore(el);
		if (data.success == true)
		    notify('Article reported');
		else
		    notify(data.info);
	    }
	});
    });
    
    data.find('#nop').click(function() {
    	restore(el);
    });

    el.find('#report').unbind('click');
    el.find('#report').html(data);

}

/********** Show comments *************/

NoctuaGUI.prototype.hideComments = function (id) {
    var el = find_article_by_id(id);
    
    el.find('.comments').toggle();
}

NoctuaGUI.prototype.showComments = function (id) {
    var el = find_article_by_id(id);

    el.find('#sb-comments')
	.attr('onclick', 'noctuaGUI.hideComments(' + id + ')');

    $.ajax({
	type : "POST",
	url : ajaxUrls.getComments,
	data : {
	    'id' : id,
	    'authenticity_token' : _token
	},
	beforeSend : function() {
	    el.find('.mid-article').append('<div class="comments"><center>' + images_rev.commentWait + '</center></div>');
	},
	success : function(data) {
	    if (data.success == false) {
		notify(data.info);
	    }
	    else {
		el.find('.comments').empty().append('<br/>').append(data.data);
		if (data.count == 'max')
		    el.find('.comments')
		    .append("<div id='post-comment'><a href='" + data.for_more_url + "'>Show more comments</a></div>");
		else
		    el.find('.comments')
		    .append('<div id="post-comment"><a href="' + data.for_more_url + '">Add a comment</a></div>');
		
	    }
	}
    });
}

/********** Add as friend **********/

NoctuaGUI.prototype.addAsFriend = function(id) {
    $.ajax({
	type : "POST",
	url : ajaxUrls.addAsFriend,
	data : { 
	    'id' : id,
	    'authenticity_token' : _token
	},
	success : function(data) {

	    if (data.success == true) {
		notify('Added as friend');
	    }
	    else {
		notify(data.info);
	    }
	}
    });
}

/************ New article asynchronous **********/

NoctuaGUI.prototype.newArticle = function(art) {

    $('#articles').prepend(art);
}