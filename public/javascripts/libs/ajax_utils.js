$(document).ready(function(){

$('.bajax').click(function() {

    source = this;
    $(this).addClass("active_ajax");

    var url =  $(this).attr('rel');
    
    var destination = $(this).attr('id');
        $(destination).load(url, {}, function(){
            $(source).removeClass("active_ajax");}
    );
        //prevent the browser to follow the link
         return false;
    });

});
// chargement de Role CSS
function chargement_css(chemin){
    alert(chemin);
   $("head").append("<link>");
    css = $("head").children(":last");
    css.attr({
      rel:  "stylesheet",
      type: "text/css",
      href: chemin
    });
}
// Chargement de javascript
function chargement_js(chemin){
}

function submit_form_to_div(id_form,id_result){
  $("#" + id_form ).submit(function(event) {

    var url = $("#" + id_form ).attr( 'action' );

    $.post( url, $("#" + id_form ).serialize(),
      function( data ) {

          $( "#" + id_result ).empty().append( data );
      }
    );
    return false;
  });




}



