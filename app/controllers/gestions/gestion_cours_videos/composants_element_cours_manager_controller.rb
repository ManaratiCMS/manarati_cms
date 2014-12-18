class Gestions::GestionCoursVideos::ComposantsElementCoursManagerController < ApplicationControllerCoreAdmin
  layout "admin"

  # Affichage des Composants d'un element de cours
  def index
     @type_contenu = params[:tc]
     @element_cour = ElementCourG3.find(params[:id])
     @cmp_composants = CmpComposant.find(:all,:order=>"ordre",:conditions=>["element_cour_g3_id = ? and type_contenu = ?",params[:id],@type_contenu])
     new 
    render :layout => layout_public
  end




  def new
    @id_parent = params[:id]
#    @width = 200
#    @height =200
    @type_contenu = params[:tc]
    @liste_article_type = CmpArticleType.find(:all,:joins => :cmp_article_type_themes,:conditions=>["cmp_article_type_themes.ref_theme = ? and is_layout = 0",@skin_public])

  end


  # Edition du composant
  def ajouter_etape_2
      @ref_art = params[:ref_art]
      @id_parent = params[:id_parent]
      @nom_zone = params[:nom_zone]
      width = params[:w]
      height = params[:h]
      @type_contenu = params[:tc]

    
      session[:page_en_cour_edition] =  params[:id_parent] # à utiliser pour la sauvegarde de texte Mathématique dans tinycms

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


     if @appel_ajax
       render :layout => false
     else
       render
     end

  end

   # Sauvegarde du composant
  def ajouter_etape_3

        article_type = CmpArticleType.find_last_by_reference(params[:ref_art])


        # peut être que la composante n'a pas de donnée ou parametre
        params[article_type.reference.to_sym][:reference] =  article_type.reference if  !params[article_type.reference.to_sym].nil?

        # Instantiation de l'objet Composant en conaissant sont type et ses paramétre
        @cmp_composant = CmpComposantAtomiqueManager.getCmpParType(article_type.type_composant,params[article_type.reference.to_sym])
        @cmp_composant.reference = article_type.reference
        @cmp_composant.fichier_css = article_type.fichier_css
        @cmp_composant.fichier_js = article_type.fichier_js
        @cmp_composant.libs_css = article_type.libs_css
        @cmp_composant.libs_js = article_type.libs_js
        @cmp_composant.element_cour_g3_id = params[:id_parent]
        @cmp_composant.type_contenu = params[:tc]
        @cmp_composant.cmp_article_type = article_type
 

      if  @cmp_composant.save
        if @appel_ajax
         render :layout => false
        else
         redirect_to "/gestions/gestion_cours_videos/composants_element_cours_manager/index/#{params[:id_parent]}?tc=#{params[:tc]}"
        end
      else
        flash[:notice] = t("GestionComposantsElementCours.msg.erreur_ajouter")
          redirect_to "/gestions/gestion_cours_videos/composants_element_cours_manager/ajouter_etape_2?ref_art=#{params[:ref_art]}&id_parent=#{params[:id_parent]}&nom_zone=#{params[:nom_zone]}"
      end
  end


    def update
    if params[:cmp_composant].blank?
      @cmp_composant = CmpComposant.find(params[:id])
      @ref_langue = "fr"
     if @appel_ajax
       render :layout => false
     else
       render
     end

    else
        @ref_langue = params[:ref_langue]
        cmp_composant = CmpComposant.find(params[:cmp_composant][:id])
        cmp_composant.update_attributes(params[cmp_composant.reference])


#     if request.xhr?
#       # Render Article Public
       render :layout => false,:partial =>"/gestions/gestion_cours_videos/composants_element_cours_manager/partials/update_result.html", :locals => { :composant => cmp_composant ,:ref_langue=>@ref_langue}
#     else
#        if @ref_langue.nil?
#        redirect_to "/admin/article_manager/update/#{article.cmp_article.id}"
#        else
#        redirect_to "/admin/article_manager/update/#{CmpArticle.find(article.ref_id).cmp_article.id}?ref_langue=#{@ref_langue}"
#        end
#     end




    end
  end


  def delete
    cmp_composant = CmpComposant.find(params[:id])
      if  cmp_composant.destroy
          flash[:notice] = t("GestionElementCours.msg.supprimer_avec_succes")
        else
        flash[:notice] = t("GestionElementCours.msg.erreur_de_suppression")
        end

     if @appel_ajax
       render :layout => false
     else
       redirect_to "/gestions/gestion_cours_videos/composants_element_cours_manager/index/#{params[:id_element]}?tc=#{params[:tc]}"
     end

    end


 


  
  def move_up
    composant = CmpComposant.find(params[:id])
    init_ordre(composant.element_cour_g3_id) if  ( composant.ordre.nil?  || composant.ordre == 0 )
    if composant.ordre > 1
        ordre_precedent = composant.ordre - 1
        article_precedent = CmpComposant.find(:first,:conditions=>['ordre = ? and element_cour_g3_id = ?',ordre_precedent,composant.element_cour_g3_id])
        composant.ordre = composant.ordre - 1
        article_precedent.ordre = article_precedent.ordre  + 1
        composant.save
        article_precedent.save
    end
    redirect_to "/gestions/gestion_cours_videos/composants_element_cours_manager/index/#{composant.element_cour_g3_id}?tc=#{composant.type_contenu}"
  end
  def move_down
    composant = CmpComposant.find(params[:id])
    init_ordre(composant.element_cour_g3_id) if  ( composant.ordre.nil?  || composant.ordre == 0 )
     if composant.ordre < CmpComposant.count(:conditions=>["element_cour_g3_id = ?",composant.element_cour_g3_id])
    ordre_suivant = composant.ordre  + 1
    article_suivant = CmpComposant.find(:first,:conditions=>['element_cour_g3_id = ? and  ordre = ?',composant.element_cour_g3_id,ordre_suivant])
    composant.ordre = composant.ordre + 1
    article_suivant.ordre = article_suivant.ordre  - 1
    composant.save
    article_suivant.save
  end
    redirect_to "/gestions/gestion_cours_videos/composants_element_cours_manager/index/#{composant.element_cour_g3_id}?tc=#{composant.type_contenu}"
  end
 





 private

   def init_ordre(id_element)
    objs = CmpComposant.find(:all,:conditions=>["element_cour_g3_id = ?",id_element])
    objs.each_with_index { |obj,i|
      obj.ordre = i + 1
      obj.save
    }
  end

   
   # Détermination de Layout Générale de Théme Active
  def layout_public
     @skin = @skin_public
     CmpTheme.theme_layout_active
  end



end
