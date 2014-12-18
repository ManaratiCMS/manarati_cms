


function page_load(){

// Masquer tous les action
$("div.article_conteneur div.action").hide();
// Aficher l'action en Hover
$("div.article_conteneur").mouseover(function(){
            $("div.article_conteneur div.action").hide();
            $("#action_" + $(this).attr("id")).show();
});
// événement click du bouton éditer
 $('a.editer').click(function() {
            var url = this.href;
            var id_article = $(this).attr('rel');
            var dialog = $("#form_update_composant");
            dialog.empty();
            dialog.dialog({height : 390,width: 500, resizable: false,zIndex: 3999, modal: false
            });
            // load remote content
            dialog.load(
                url,
                {}, // omit this param object to issue a GET request instead a POST request, otherwise you may provide post parameters within the object
               function() {
                     submit_form_to_div("form_cmp", "contenu_article_" + id_article );
                }
            );
            //prevent the browser to follow the link
            return false;
        });
  // événement click du bouton supprimer le composant
 $('a.supprimer').click(function() {
            var url = this.href;
            var id_article = $(this).attr('rel');
            var dialog = $("#article_" + id_article);
            //dialog.empty();
            // load remote content
            dialog.load(
                url,
                {}, // omit this param object to issue a GET request instead a POST request, otherwise you may provide post parameters within the object
               function() {
                dialog.remove();
              }
            );
            //prevent the browser to follow the link
            return false;
        });
}

$(document).ready(function(){
page_load();

// Menu Update Site
$("#menu_update_site").dialog({
                width : 500,
                height : 100,
                position: ["right","top"],
                modal: false,
                 resizable: false
            });

// Loaginf Ajax
$("#loading").hide();
$("#loading").ajaxStart(function(){$(this).show();});
$("#loading").ajaxComplete(function(){$(this).hide();});
 
 



$('.message_box').click(function() {

alert("update");
     $("#form_update_composant").dialog( "option", "height", 500 );

});



 

        // événement clikc sur les boutons de la boute à outils
         $('a.add_cmp').click(function() {
            var url = this.href;
            var dialog = $("#form_update_composant");
            dialog.empty();
            dialog.dialog({
                height : 390,
                width: 500,
                resizable: false,
                zIndex: 3999,
                modal: false
            });

            // load remote content
            dialog.load(
                url,
                {}, // omit this param object to issue a GET request instead a POST request, otherwise you may provide post parameters within the object
               function() {
                  $("#form_cmp").submit(function(event) {
                    var url = $("#form_cmp").attr( 'action' );
                    $.post( url, $("#form_cmp").serialize(),
                      function( data ) {
                          $( "#composants").append( data );
                          page_load();
                      }
                    );
                    return false;
                  });
                }
            );
            //prevent the browser to follow the link
            return false;
        });
});


//$(".zone_layout").mouseover(
//        function(){
////            $("div.bt_ajouter").hide();
////            $(this).find(".bt_ajouter");
//        });
//$("div.action").mouseout(function(){
////            $(this).hide();
//});

function update_dialog(id,height){
      alert($("#form_update_composant").dialog( "option", "height"));
     $("#form_update_composant").dialog( "option", "height", 500 );
     alert($("#form_update_composant").dialog( "option", "height"));

}



