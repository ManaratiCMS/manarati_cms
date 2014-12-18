//-------------------------------------------------------------
//	Created by: ESSARRAJ fouad
//	Site: www.manarati.net
//---------------------------------------------------------------



tinyMCEPopup.requireLangPack();
var Manarati_Image_Dialog = {
	init : function() {
		 
	},

	insert : function() {
//		var urlServer = tinyMCEPopup.editor.plugins["manarati_image"].getUrlViewer();
		var imgTag = '<img class="imgage" src="" border="0"/>';
		tinyMCEPopup.editor.execCommand('mceInsertContent', false, imgTag);
		tinyMCEPopup.close();
	},
	update : function() {
//		tinyMCEPopup.editor.plugins["fmath_formula"].updateMathML(name, mathml);
//
//		var imgName = document.getElementById('mathml_n').value;
//
//		tinyMCEPopup.editor.dom.setAttrib(name, 'src', imgName);
//
//
//		tinyMCEPopup.close();
	}
	
};

tinyMCEPopup.onInit.add(Manarati_Image_Dialog.init, Manarati_Image_Dialog);

