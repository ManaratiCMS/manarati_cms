
# Gestion des Composant 

class Admin::ArticleManagerController < ApplicationControllerCoreAdmin
  layout "admin"
  filter_access_to [:ajouter_etape_3] ,:model=>:cmp_page,:attribute_check=>true,:load_method => lambda { CmpPage.find(params[:id_page]) }
  filter_access_to [:update,:supprimer,:move_up,:move_down] ,:model=>:cmp_page,:attribute_check=>true,:load_method => lambda { CmpArticle.find(params[:id]).cmp_page }



  #Etape1 :  Ajouter : choix de l'article Type : Article Modéle
  def ajouter
    @id_page = params[:id_page]
    @cmp_page = CmpPage.find(@id_page)
#    @liste_article_type = ArticleTypeManager.get_tous
     @liste_article_type = CmpArticleType.find(:all,:joins => :cmp_article_type_themes,:conditions=>["cmp_article_type_themes.ref_theme = ?",@skin_public])



  end



  # Edition de l'article
  def ajouter_etape_2
      @ref_art = params[:ref_art]
      @id_page = params[:id_page]
      session[:page_en_cour_edition] = params[:id_page] # à utiliser pour la sauvegarde de texte Mathématique dans tinycms

      # il faut appeler le constrecteur pour chaque composant
      # en remplaçant la liste de composant dans l'objet article_type par une liste
      # contenant des composant initialsés
      @article_type = CmpArticleType.find_last_by_reference(@ref_art)

    if @article_type.have_form == 0
      params[:ref_art] = @ref_art
      params[:article] = nil
      ajouter_etape_3
    end
  end

  # Sauvegarde de l'article
  def ajouter_etape_3

      params[:article] ={}  if params[:article].nil?

      article_type = CmpArticleType.find_last_by_reference(params[:ref_art])

      article = CmpArticle.new(params[:article])
      article.ref_article_classe = article_type.reference
      article.fichier_css = article_type.fichier_css
      article.fichier_js = article_type.fichier_js
      article.libs_css = article_type.libs_css
      article.libs_js = article_type.libs_js
      article.cmp_page_id = params[:id_page]


     article_type.cmp_composants.each { |composant|
        # peut être que la composante n'a pas de donnée ou parametre
        params[composant.reference.to_sym][:reference] =  composant.reference if  !params[composant.reference.to_sym].nil?

        # Instantiation de l'objet Composant en conaissant sont type et ses paramétre
        cmp_composant = CmpComposantAtomiqueManager.getCmpParType(composant.type,params[composant.reference.to_sym])
        
        cmp_composant.reference = composant.reference
 
        cmp_composant.label_form = composant.label_form

      if composant.type == "CmpPhoto"
        cmp_composant.width = composant.width
        cmp_composant.height = composant.height
      end

       
        article.cmp_composants << cmp_composant
      }
     

    if  article.save_parent()
        if article.cmp_page.formation.nil?
        redirect_to "/admin/pages_manager/edit?id=#{params[:id_page]}&ref_article=#{article.id}"
        else
          redirect_to "/admin/formation_page_manager/edit?id=#{params[:id_page]}&ref_article=#{article.id}"
        end
      else
        flash[:notice] = t("GestionArticles.msg.erreur_lors_redirection_vers_page_sender")
        if article.cmp_page.formation.nil?
        redirect_to "/admin/pages_manager/edit?id=#{params[:id_page]}"
        else
          redirect_to "/admin/formation_page_manager/edit?id=#{params[:id_page]}"
        end
      end
  end

  def supprimer
     page = CmpPage.find(CmpArticle.find(params[:id]).cmp_page_id)
     CmpArticle.destroy_parent(params[:id])

     if page.formation.nil?
     redirect_to "/admin/pages_manager/edit?id=#{page.id}"
     else
     redirect_to "/admin/formation_page_manager/edit?id=#{page.id}"  
     end

  end

  def update
    if params[:article].blank?
      @article = CmpArticle.find(params[:id])
      @ref_langue = params[:ref_langue]
      @langues_active = CmpLangue.liste_objt_langues_actives
      if @ref_langue
        @traduction = true 
        @langue = CmpLangue.find_by_reference(@ref_langue)
      end
      @cmp_page = @article.cmp_page
      @cmp_pages = CmpPage.find(:all,:order=>"ordre")
      render :layout => layout_public
    else
      if !params[:id].blank?
        CmpArticle.update(params[:id], params[:article])
        article =  CmpArticle.find(params[:id])
        article.cmp_composants.each { |composant|
          composant.update_attributes(params[composant.reference])
        }
      
        redirect_to "/admin/formation_page_manager/edit?id=#{article.cmp_page_id}"
     
      end
    end
  end

   # Déplacer le composant en haut
  def move_up
    article = CmpArticle.find(params[:id])
    article.move_up
    redirect_to "/admin/pages_manager/edit?id=#{article.cmp_page_id}&ref_article=#{article.id}"

  end

  # Déplacer le composant en bas
  def move_down
    article = CmpArticle.find(params[:id])
    article.move_down
    redirect_to "/admin/pages_manager/edit?id=#{article.cmp_page_id}&ref_article=#{article.id}"
   

  end

  private
   # Détermination de Layout Générale de Théme Active
  def layout_public
     @skin = @skin_public
     CmpTheme.theme_layout_active
  end
end
