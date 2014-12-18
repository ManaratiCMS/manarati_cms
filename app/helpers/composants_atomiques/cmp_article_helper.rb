#  require 'fileutils'
  
module ComposantsAtomiques::CmpArticleHelper

  # Afficher Article Avec Meta Donnée : Date de Creation , Nom Article 
  def cmp_affiche_article(article)
        render :partial => "composants_atomiques/cmp_article/affiche_article", :locals => { :article => article }
  end

#  Afficher un article Sans Meta Donnée
# args :  {:width=> 200}
  def cmp_affiche_article_sans_meta_donnees(article,args={})
        style = ""
        style +=  " style ='width : #{args[:width]}px'"  unless args[:width].nil?
        render :partial => "composants_atomiques/cmp_article/affiche_article_sans_meta_donnees", :locals => { :article => article,:style=>style }
  end

#  Afficher un  Composant 
  def cmp_affiche_composant(composant,args={})
        render :partial => "composants_atomiques/cmp_article/affiche_composant", :locals => { :composant => composant }
  end

  def cmp_affiche_article_by_reference(reference_article)
        article = Article.charger(reference_article)
        cmp_affiche_article(article)
  end

  def cmp_affiche_article_by_reference_and_group(reference_article)
        article = Article.charger(reference_article)
        render :partial => "composants_atomiques/cmp_article/affiche_article", :locals => { :article => article }
  end

  # Importation de Style CSS d'une article
  def cmp_article_style_sheet(article)
      str = ""
#     if  @theme.use_system_theme == 1
#      str += stylesheet_link_tag "themes/public_sys/articles/#{article.fichier_css}"
#      str += "\n"
#     end

  # si le fichier n'existe pas on importe le fichier de theeme public_sys
  if File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{@skin_public}/articles/#{article.fichier_css}") or File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{@skin_public}/articles/#{article.fichier_css}.css")
     str += stylesheet_link_tag "themes/#{@skin_public}/articles/#{article.fichier_css}"
  else
     str += stylesheet_link_tag "themes/public_sys/articles/#{article.fichier_css}"
  end
     
  str
  end


  # Chemin des fichiers CSS
   def cmp_article_chemin_css(article)
      str = ""
  # si le fichier n'existe pas on importe le fichier de theeme public_sys
  if File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{@skin_public}/articles/#{article.fichier_css}") or File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{@skin_public}/articles/#{article.fichier_css}.css")
     str += "/stylesheets/themes/#{@skin_public}/articles/#{article.fichier_css}"
  else
     str +=  "/stylesheets/themes/public_sys/articles/#{article.fichier_css}"
  end
  str
  end


  # Importation de library CSS d'une article
  def cmp_article_add_libs_style_sheet(article)
    liste_styles = ""
    article_type = article.cmp_article_type
    if !article_type.libs_css.blank?
      chemins = article_type.libs_css.split(',')
      chemins.each { |chemin|
      str = ""

        if File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{@skin_public}/#{chemin}") or File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{@skin_public}/#{chemin}.css")
        str += stylesheet_link_tag("themes/#{@skin_public}/" + chemin)
        else
          str += stylesheet_link_tag("themes/public_sys/" + chemin)
        end


        liste_styles  = liste_styles + str
      }
    end
    liste_styles
  end

  # les chemin CSS
   def cmp_article_add_libs_chemin_css(article)
    liste_styles = Array.new
    if !article.libs_css.blank?
      chemins = article.libs_css.split(',')
      chemins.each { |chemin|
        if File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{@skin_public}/#{chemin}") or File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{@skin_public}/#{chemin}.css")
        liste_styles  << "/stylesheets/themes/#{@skin_public}/" + chemin
        else
         liste_styles  << "/stylesheets/themes/public_sys/" + chemin
        end
      }
    end
    liste_styles
  end


  def cmp_article_fichier_js(article)
    javascript_include_tag "articles/#{article.fichier_js}"
  end
  def cmp_article_add_libs_js(article)
    liste_js = ""
    if !article.libs_js.blank?
      chemins = article.libs_js.split(',')
      chemins.each { |chemin|
        liste_js  = liste_js + javascript_include_tag(chemin)
      }
    end
    liste_js
  end

  def cmp_article_charger_composant_par_element_article(cmp_obj)
   eval(StringManager.nom_fichier_class(cmp_obj.type.to_s) +  "_form(cmp_obj)")
  end

  


end
