/*
 * jQuery HeatColor - by Strzelewicz Alexandre
 *
 * Copyright 2011, Strzelewicz Alexandre
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Autocomplete
 *
 * Depends:
 *	jquery
 *	jquery.ui.core.js
 */

(function($){
    $.fn.extend({ 
		
        heatcolor: function(options) {

	    var utils = {
		rgbToHex : function rgb(red, green, blue) {
		    var rgb = blue | (green << 8) | (red << 16);
		    return '#' + rgb.toString(16);
		}
	    }
            var defaults = {
		val : Math.floor(Math.random()*100),
		displayText : true,
		animate : true,
		delayMs : 120,
		caractersToAdd : '',
		valueCss : 'margin : 5px 0 5px 0'
            }
          
            var options =  $.extend(defaults, options);
 
            return this.each(function() {
                var o = options;
		var parentElWidth = $(this).css('width').replace(/[^-\d\.]/g, '');

		var colorVal = 2.5 * (100 - o.val);
		//$(this).css('background-color', utils.rgbToHex(255,colorVal,colorVal));
		
		//$(this).append('<span style="display : inline-block; ' + o.valueCss + '">&nbsp;</span>');
		
		// sttyle pas pris en compte.
		
		$(this).append('<div style="" style="'+ o.valueCss + '"></div>');
		
		var tmpEl = $(this).children();
		// Display text ?
		if (o.displayText == true)		    
		    tmpEl.html(o.val + o.caractersToAdd);
		//tmpEl.css({'background-color':utils.rgbToHex(255, colorVal, colorVal)});
		
		// light hack
		var width = (o.val / 100) * parentElWidth - 3;
		var effect = {'width': width, 'background-color' : utils.rgbToHex(255, colorVal, colorVal)};

		// Avoid lags load
		if (o.animate == true) {
		    setTimeout(function(){tmpEl.animate(effect)}, o.delayMs);
		}
		else
		    tmpEl.css(effect);
		
            });
        }
    });     
})(jQuery);