class Admin::LayoutComposantsManagerController < ApplicationControllerCoreAdmin

 layout "admin"

#  filter_access_to [:supprimer,:move_up,:move_down,:ajouter,:ajouter_etape_2,:ajouter_etape_3,:update] ,:model=>:cmp_page,:attribute_check=>true,:load_method => lambda { CmpArticle.find(params[:id_parent]).cmp_page }


  def ajouter
    @id_parent = params[:id_parent]
    @nom_zone = params[:nom_zone]
    @width = params[:w]
    @height =params[:h]
    @liste_article_type = CmpArticleType.find(:all,:joins => :cmp_article_type_themes,:conditions=>["cmp_article_type_themes.ref_theme = ? and is_layout = 0",@skin_public])

  end

  # Edition de l'article
  def ajouter_etape_2
      @ref_art = params[:ref_art]
      @id_parent = params[:id_parent]
      @nom_zone = params[:nom_zone]
      width = params[:w]
      height = params[:h]
      session[:page_en_cour_edition] = params[:id_page] # à utiliser pour la sauvegarde de texte Mathématique dans tinycms

      # il faut appeler le constrecteur pour chaque composant
      # en remplaçant la liste de composant dans l'objet article_type par une liste
      # contenant des composant initialsés
      @article_type = CmpArticleType.find_last_by_reference(@ref_art)
      @article_type.width = width
      @article_type.height = height

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
      article.cmp_article_id = params[:id_parent]
      article.nom_zone = params[:nom_zone]


     article_type.cmp_composants.each { |composant|
        # peut être que la composante n'a pas de donnée ou parametre
        params[composant.reference.to_sym][:reference] =  composant.reference if  !params[composant.reference.to_sym].nil?

        # Instantiation de l'objet Composant en conaissant sont type et ses paramétre
        cmp_composant = CmpComposantAtomiqueManager.getCmpParType(composant.type,params[composant.reference.to_sym])

        cmp_composant.reference = composant.reference
        cmp_composant.label_form = composant.label_form

#  


        article.cmp_composants << cmp_composant
      }


    if  article.save_fils()
          redirect_to "/admin/article_manager/update?id=#{params[:id_parent]}"
      else
        flash[:notice] = t("GestionArticles.msg.erreur_lors_redirection_vers_page_sender")
          redirect_to "/admin/layout_composants_manager/ajouter_etape_2?ref_art=#{params[:ref_art]}&id_parent=#{params[:id_parent]}&nom_zone=#{params[:nom_zone]}"

      end
  end


 def update
    if params[:article].blank?
      @article = CmpArticle.find(params[:id])
      @ref_langue = params[:ref_langue]


     if @appel_ajax
       render :layout => false
     else
       render 
     end
#
#     respond_to do |format|
#       format.html {   }
#       format.js   {  }
#     end


    else

        @ref_langue = params[:ref_langue]
        CmpArticle.update(params[:article][:id], params[:article])
        article =  CmpArticle.find(params[:article][:id])
        article.cmp_composants.each { |composant|
          composant.update_attributes(params[composant.reference])
        }

     if request.xhr?
       # Render Article Public
       render :layout => false,:partial =>"/admin/layout_composants_manager/partials/update_result.html", :locals => { :article => article ,:ref_langue=>@ref_langue}
     else
        if @ref_langue.nil?
        redirect_to "/admin/article_manager/update/#{article.cmp_article.id}"
        else
        redirect_to "/admin/article_manager/update/#{CmpArticle.find(article.ref_id).cmp_article.id}?ref_langue=#{@ref_langue}"
        end
     end


      

    end
  end

  def traduir
     @article_langue_princiaple = CmpArticle.find(params[:id])
     @ref_langue = params[:ref_langue]
     @article = CmpArticle.find(:first,:conditions=>["ref_id = ? and langue = ?",@article_langue_princiaple.id,@ref_langue])
     # Création du composant s'il n'existe pas
     if @article.nil?
       article_parent = @article_langue_princiaple.cmp_article.article_traduit(@ref_langue)
       CmpArticle.add_article_type_to_liste_article(@ref_langue,@article_langue_princiaple.ref_article_classe, @article_langue_princiaple.id,article_parent.id,@article_langue_princiaple.nom_zone)
       @article = CmpArticle.find(:first,:conditions=>["ref_id = ? and langue = ?",@article_langue_princiaple.id,@ref_langue])
     end
     redirect_to "/admin/layout_composants_manager/update/#{@article.id}?ref_langue=#{@ref_langue}&id_parent=#{params[:id_parent]}"

  end

  def supprimer
     article =  CmpArticle.find(params[:id])
     CmpArticle.destroy_fils(params[:id])
     redirect_to "/admin/article_manager/update/#{article.cmp_article.id}"
  end


   # Déplacer le composant en haut
  def move_up
    article = CmpArticle.find(params[:id])
    article.move_up_fils
    redirect_to "/admin/article_manager/update/#{article.cmp_article.id}"
  end

  # Déplacer le composant en bas
  def move_down
    article = CmpArticle.find(params[:id])
    article.move_down_fils
    redirect_to "/admin/article_manager/update/#{article.cmp_article.id}"
  end

end
