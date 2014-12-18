function init_paragraphe(){

 
tinyMCE.init({
		// General options
		mode : "textareas",
		theme : "advanced",
		plugins : "manarati_image,style,fmath_formula,table,advlink,insertdatetime,media,searchreplace,print,paste,fullscreen,visualchars,nonbreaking,xhtmlxtras,wordcount,advlist",
                height : "200",
                
                convert_urls : false,
		// Theme options
		theme_advanced_buttons1 : "undo,redo,|,bold,italic,strikethrough,sub,sup,|,bullist,numlist,|,link,unlink,|,removeformat,pasteword,|,code,fullscreen",
		theme_advanced_buttons2 : "manarati_image,fmath_formula,insertdate,search",
		theme_advanced_buttons3 :  "",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : false,

		// Example content CSS (should be your site CSS)
		//content_css : "css/content.css",

		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Style formats
		style_formats : [
			{title : 'Bold text', inline : 'b'},
			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
			{title : 'Example 1', inline : 'span', classes : 'example1'},
			{title : 'Example 2', inline : 'span', classes : 'example2'},
			{title : 'Table styles'},
			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
		],

		formats : {
		//	alignleft : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'left'},
		//	aligncenter : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'center'},
		//	alignright : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'right'},
		//	alignfull : {selector : 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes : 'full'},
		//	bold : {inline : 'span', 'classes' : 'bold'},
		//	italic : {inline : 'span', 'classes' : 'italic'},
		//	underline : {inline : 'span', 'classes' : 'underline', exact : true},
			strikethrough : {inline : 'del'}
		},

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		},
                setup : function(ed) {
                    ed.onChange.add(function(ed, l) {
                    var content = ed.save();
                    });
                }

	});
}
