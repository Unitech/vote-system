
var cookie = {
    setCookie : function(name,value,days) {
	if (days) {
            var date = new Date();
            date.setTime(date.getTime()+(days*24*60*60*1000));
            var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
    },
    getCookie : function(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
    },
    deleteCookie : function(name) {
	this.setCookie(name,"",-1);
    },
    push_val : function(cname, val){
	var data = this.getCookie(cname);

	if (data == null){
            this.setCookie(cname, val, 99);
            return true;
	}
	data += ',' + val;
	this.setCookie(cname, data, 99);
    },
    get_values : function(cname){
	var data = this.getCookie(cname);
	if (data){
            data = data.split(',');
            return data;
	}
	return null;
    }
}
