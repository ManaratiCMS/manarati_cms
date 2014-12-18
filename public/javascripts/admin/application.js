/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function jcmp_text_to_calendar(input_text_id){
  $(document).ready(function() {
//    input_text_id = "#" + input_text_id;
//    reference_id = "#" + reference_id;
//    $(input_text_id).change( function() {
//        var ref_str = str_to_reference($(input_text_id).val());
//        $(reference_id).val(ref_str);
//    })
   });
}


// Transformer une chaine de caractére à un nom de classe Ruby
function str_to_nom_classe(str){

  var i = 0;
  var str_r = "";
  str =  str.toString().toLowerCase();
  var prochaine_char_to_uper_case = 0;
  str_r = str_r + str.charAt(0).toUpperCase();
  for(i=1;i<str.length;i++){


     if ( str.charCodeAt(i) >=  97 &&  str.charCodeAt(i) <= 122 || str.charCodeAt(i) >=   48 &&  str.charCodeAt(i) <=57 ){
         if (prochaine_char_to_uper_case == 0)
         str_r = str_r + str.charAt(i).toString();
         else{
         str_r = str_r + str.charAt(i).toUpperCase();
         prochaine_char_to_uper_case = 0;
         }
     }
         

     switch (str.charAt(i)) {
            case '-':
                str_r = str_r + '-'.toString();
                break;
            case ' ':
                str_r = str_r + ''.toString();
                prochaine_char_to_uper_case = 1;
                break;
            case 'é':
                str_r = str_r + 'e'.toString();
                break;
            case 'è':
                str_r = str_r + 'e'.toString();
                break;
            case '_':
                str_r = str_r + '_'.toString();
                break;
            case 'ç':
                str_r = str_r + 'c'.toString();
                break;
            case 'à':
                str_r = str_r + 'a'.toString();
                break;
            case 'ê':
                str_r = str_r + 'e'.toString();
                break;
           
            default:
                break;
        }

        
  }
  return str_r;
}

// Transformer un chaine de caractère vers une référence
function str_to_reference(str){

  var i = 0;
  var str_r = "";
  str =  str.toString().toLowerCase();
 
  for(i=0;i<str.length;i++){


     if ( str.charCodeAt(i) >=  97 &&  str.charCodeAt(i) <= 122 || str.charCodeAt(i) >=   48 &&  str.charCodeAt(i) <=57 )
         str_r = str_r + str.charAt(i).toString();
     switch (str.charAt(i)) {
            case '-':
                str_r = str_r + '-'.toString();
                break;
            case ' ':
                str_r = str_r + '_'.toString();
                break;
            case 'é':
                str_r = str_r + 'e'.toString();
                break;
            case 'è':
                str_r = str_r + 'e'.toString();
                break;
            case '_':
                str_r = str_r + '_'.toString();
                break;
            case 'ç':
                str_r = str_r + 'c'.toString();
                break;
            case 'à':
                str_r = str_r + 'a'.toString();
                break;
            case 'ê':
                str_r = str_r + 'e'.toString();
                break;
           
            default:
                break;
        }

        
  }
  return str_r;
}

// Générer le référecne à partire d'une Zone de Texte'
function Bind_InputText_to_reference(input_text_id,reference_id){

  $(document).ready(function() {
    input_text_id = "#" + input_text_id;
    reference_id = "#" + reference_id;
    $(input_text_id).change( function() {
        var ref_str = str_to_reference($(input_text_id).val());
        $(reference_id).val(ref_str);
        $(reference_id).change();
    })
   });
   
}
// Générer le référecne à partire d'une Zone de Texte' avec préfixe
function Bind_InputText_to_Reference_With_Prefixe(input_text_id,reference_id,prefixe){
  $(document).ready(function() {
    input_text_id = "#" + input_text_id;
    reference_id = "#" + reference_id;
    $(input_text_id).change( function() {
        var ref_str = prefixe +  str_to_reference($(input_text_id).val());
        $(reference_id).val(ref_str);
        $(reference_id).change();
    })
   });
}
// Générer le référecne à partire d'une Zone de Texte' avec préfixe
function Bind_InputText_to_Classe_With_Prefixe(input_text_id,reference_id,prefixe){
  $(document).ready(function() {
    input_text_id = "#" + input_text_id;
    reference_id = "#" + reference_id;
    $(input_text_id).change( function() {
        var ref_str = prefixe +  str_to_nom_classe($(input_text_id).val());
        $(reference_id).val(ref_str);
        $(reference_id).change();
    })
   });
}

// Générer le référecne à partire d'une Zone de Texte' avec préfixe
function Bind_InputText_to_Div_With_Suffix(input_text_id,div_id,suffix){
  $(document).ready(function() {
    input_text_id = "#" + input_text_id;
    div_id = "#" + div_id;
    $(input_text_id).change( function() {
        var str =  $(input_text_id).val() + suffix;
        $(div_id).html(str)    ;
    })
   });
}

function Bind_InputText_to_InpiteText_width_endstr(input_text1_id,input_text2_id,endstr){
  $(document).ready(function() {
    input_text1_id = "#" + input_text1_id;
    input_text2_id = "#" + input_text2_id;
    $(input_text1_id).change( function() {
        var str =  $(input_text1_id).val() + endstr ;
        $(input_text2_id).val(str)    ;
        $(input_text2_id).change();
    })
   });
}

function Add_InputText_to_reference(input_text_id,reference_id,separator,position_separator){
  $(document).ready(function() {
    input_text_id = "#" + input_text_id;
    reference_id = "#" + reference_id;
    $(input_text_id).change( function() {
        var ref_str = str_to_reference($(input_text_id).val());
        reference = $(reference_id).val().split(separator)[position_separator] + separator + ref_str;
        $(reference_id).val(reference);
    })
   });
}