module System::ArticlesHelper


def importation_css_article_page(page)
   importation_css_articles(page.cmp_articles)
  end



  # Importation des Fichiers Css de tous les article d'une page
  def importation_css_articles(articles,library_included = [])
    css_liens = ""
    articles.each { |article|

    article_type = article.cmp_article_type
    # Fichier CSS
    if  !library_included.include?(article_type.fichier_css) and !article_type.fichier_css.blank?
       css_liens << "\n" if library_included.length > 0
       # Importation de fichier lier au l'article
       css_liens <<  " " + cmp_article_style_sheet(article_type)
       # indication que les fichier sont déja chargés
       library_included <<  article_type.fichier_css
    end
    #Library
    if  !library_included.include?(article_type.libs_css) and !article_type.libs_css.blank?
       css_liens << "\n" if library_included.length > 0
       # importation de librarys lié au article
       css_liens << cmp_article_add_libs_style_sheet(article)
       # indication que les fichier sont déja chargés
       library_included << article_type.libs_css
    end

    # Fichier CSS et Library des fils
    if !article.cmp_articles.nil?
    css_liens << importation_css_articles(article.cmp_articles,library_included)
    end

   } unless articles.nil?

    css_liens
  end
  def importation_js_article_page(page)
   importation_js_articles(page.cmp_articles)
  end
  def importation_js_articles(articles,library_included = [])
    js_liens = ""

    articles.each { |article|

     article_type = article.cmp_article_type
      # Lib
    if  !library_included.include?(article_type.libs_js) and !article_type.libs_js.blank?
       js_liens << "\n" if library_included.length > 0
       # Importation de library JS
       js_liens << cmp_article_add_libs_js(article_type)
       library_included << article_type.libs_js
    end

    # Fichier JS
    if  !library_included.include?(article_type.fichier_js) and !article_type.fichier_js.blank?
       js_liens << "\n" if library_included.length > 0
       # Importation de fichier lié à l'article
       js_liens <<  cmp_article_fichier_js(article_type)
       library_included <<  article_type.fichier_js

    end

    # Fichier JS  et Library
    if !article.cmp_articles.nil?
    js_liens << importation_js_articles(article.cmp_articles,library_included)
    end


   } unless articles.nil?
    js_liens
  end




  def importation_css_article_type(article_type)
    liste = Array.new
    liste << article_type
    importation_css_composants(liste)
  end

   # Importation des Fichiers Css de tous les article d'une page
  def importation_css_composants(articles,library_included = [])
    css_liens = ""
    articles.each { |article|
    # Fichier CSS
    if  !library_included.include?(article.fichier_css) and !article.fichier_css.blank?
       css_liens << "\n" if library_included.length > 0
       # Importation de fichier lier au l'article
       css_liens <<  " " + cmp_article_style_sheet(article)
       # indication que les fichier sont déja chargés
       library_included <<  article.fichier_css
    end
    #Library
    if  !library_included.include?(article.libs_css) and !article.libs_css.blank?
       css_liens << "\n" if library_included.length > 0
       # importation de librarys lié au article
       css_liens << cmp_article_add_libs_style_sheet(article)
       # indication que les fichier sont déja chargés
       library_included << article.libs_css
    end

    

   } unless articles.nil?

    css_liens
  end



   # Importation des Fichiers Css de tous les article d'une page
  def chemins_css_composants(article,library_included = [])
    css_liens = Array.new
    # Fichier CSS
    if  !library_included.include?(article.fichier_css) and !article.fichier_css.blank?
       # Importation de fichier lier au l'article
       css_liens << cmp_article_chemin_css(article)
       # indication que les fichier sont déja chargés
       library_included <<  article.fichier_css
    end
    #Library
    if  !library_included.include?(article.libs_css) and !article.libs_css.blank?
       # importation de librarys lié au article
       css_liens << cmp_article_add_libs_chemin_css(article)
       # indication que les fichier sont déja chargés
       library_included << article.libs_css
    end
    css_liens
  end

  def importation_js_article_type(article_type)
    liste = Array.new
    liste << article_type
    importation_js_composants(liste)
  end

  def importation_js_article_page(page)
   importation_js_articles(page.cmp_articles)
  end
  def importation_js_composants(articles,library_included = [])
    js_liens = ""

    articles.each { |article|
      # Lib
    if  !library_included.include?(article.libs_js) and !article.libs_js.blank?
       js_liens << "\n" if library_included.length > 0
       # Importation de library JS
       js_liens << cmp_article_add_libs_js(article)
       library_included << article.libs_js
    end

    # Fichier JS
    if  !library_included.include?(article.fichier_js) and !article.fichier_js.blank?
       js_liens << "\n" if library_included.length > 0
       # Importation de fichier lié à l'article
       js_liens <<  cmp_article_fichier_js(article)
       library_included <<  article.fichier_js

    end

   


   } unless articles.nil?
    js_liens
  end





  
end
