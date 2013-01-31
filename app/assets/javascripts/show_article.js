$(document).ready(function() {
    // $('#new_comment').submit(function(e){
    // 	e.preventDefault();
    // 	var data_form = {'comment': {'anonymous_nick' : $('input#comment_anonymous_nick').val(),
    // 				     'anonymous_url' : $('input#comment_anonymous_url').val(),
    // 				     'content' : $('input#comment_content').val(),
    // 				     'article_id' : $('input#comment_article_id').val()}
    // 			};

    // 	var self = $(this);
    // 	$.ajax({
    // 	    type : "POST",
    // 	    url : ajaxUrls.commentArticle,
    // 	    data : data_form,
    // 	    success : function(data) {
    // 		if (data.success == false) {
    // 		    notify('A field is wrong');
    // 		    return;
    // 		}
    // 		$('input[type=submit]').attr('disabled', 'disabled');
    // 		$('.content').append('<div class="cmt"><div class="meta">by Me, now</div><div class="ctn">' + data_form.comment.content + '</div></div>');
    // 	    }

    // 	});


    // });
});