module ComposantsAtomiques::CmpComposantHelper
  def cmp_composant_lib_js_form(composant)
    file = "composants_atomiques/#{StringManager.nom_fichier_class(composant.type.to_s)}/#{StringManager.nom_fichier_class(composant.type.to_s)}_form"
    file_js = "#{RAILS_ROOT}/public/javascripts/#{file}.js"
    if File.exists?(file_js)
      return  javascript_include_tag file
    else
    return ""
    end
  end

  def cmp_composant_lib_css_form(composant)
    return ""
  end

  def cmp_composant_add_library(library)
    html = ""
    case library
      when "editeur_wysiwyg"
        html << "<script type='text/javascript' src='/javascripts/libs/wysiwyg/tinymce/jscripts/tiny_mce/tiny_mce.js'></script>"
        html << "<script type='text/javascript' src='/javascripts/libs/wysiwyg/tinymce/config.js'></script>"
      when "editeur_wysiwyg_simple"
        html << "<script type='text/javascript' src='/javascripts/libs/wysiwyg/tinymce/jscripts/tiny_mce/tiny_mce.js'></script>"
        html << "<script type='text/javascript' src='/javascripts/libs/wysiwyg/tinymce/config_simple.js'></script>"
      when "editeur_wysiwyg_paragraphe"
        html << "<script type='text/javascript' src='/javascripts/libs/wysiwyg/tinymce/jscripts/tiny_mce/tiny_mce.js'></script>"
        html << "<script type='text/javascript' src='/javascripts/libs/wysiwyg/tinymce/config_paragraphe.js'></script>"


    end
    html
  end


  def cmp_composant_add_lib_by_style(nom_composant,nom_style)
     stylesheet_link_tag "themes/#{@skin}/composants_atomiques/#{nom_composant}/#{nom_style}/style"
  end
  

  def cmp_composant_include
    render :partial=>"/composants_atomiques/cmp_composant/cmp_composant_include"
  end

end
