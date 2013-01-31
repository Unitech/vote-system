
var JSON = JSON || {};  

// implement JSON.stringify serialization
JSON.stringify = JSON.stringify || function (obj) {
    var t = typeof (obj);
    if (t != "object" || obj === null) {
	// simple data type
	if (t == "string") obj = '"'+obj+'"';
	return String(obj);
    }
    else {
	// recurse array or object
	var n, v, json = [], arr = (obj && obj.constructor == Array);
	for (n in obj) {
	    v = obj[n]; t = typeof(v);
	    if (t == "string") v = '"'+v+'"';
	    else if (t == "object" && v !== null) v = JSON.stringify(v);
	    json.push((arr ? "" : '"' + n + '":') + String(v));
	}
	return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
    }
};


// implement JSON.parse de-serialization
JSON.parse = JSON.parse || function (str) {
    if (str === "") str = '""';
    eval("var p=" + str + ";");
    return p;
};

    // var test = {
    // 	'vs1' : ['1','2','3'],
    // 	'vs2' : ['sad']
    // }

    // console.log(objectToString(test));

    //console.log(JSON.parse(cookie.getCookie('lbv')));

    // console.log(JSON.stringify(test));
    
    // cookie.push_val('lbv', JSON.stringify(test));




var rdy = 0;

$(document).ready(function(){
    rdy = 1;
});

function notify(str, time){
	if (rdy == 1){
            rdy = 0;
            time = typeof(time) != 'undefined' ? time : 2200;
	    var note = $('#notificator');
            note.html(str);
            note.slideDown().delay(time).slideUp(function(){rdy=1});
	}
    return false;
}


function set_auto_text(el, str_cmt)
{
    el.val(str_cmt);
    el.focus(function(){
        if(this.value == str_cmt) {
            this.value = '';
        }
    });
    el.blur(function(){
        if (this.value == '') {
            this.value = str_cmt;
        }
    });
}

function find_article_by_id(id) {
    var el = $('.art', '.page-container');
    for (var i = 0; i < el.length; i++) {
	if (id == $(el[i]).attr('alt'))
	    return $(el[i]);
    }
    return null;
}
