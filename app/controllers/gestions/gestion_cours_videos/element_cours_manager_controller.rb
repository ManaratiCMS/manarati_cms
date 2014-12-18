class Gestions::GestionCoursVideos::ElementCoursManagerController < ApplicationControllerCoreAdmin

  layout "admin"

  def index
    @id_formation = params[:id]
    @page = CmpPage.new(:titre=>t("GestionElementCours.titre_de_gestion"))
    @langues_disponibles = CmpLangue.langues_actives
    @element_cours = ElementCourG3.find(:all,:conditions=>["formation_g2_id = ?",@id_formation],:order=>"ordre")
  end


  #Ajouter une nouvelle element de cours
  def new
    @formation = FormationG2.find(params[:id])
    @page = CmpPage.new(:titre=>t("GestionElementCours.Pages.Ajouter.titre"))
    @element_cour = ElementCourG3.new
  end


  def create
        element_cour = ElementCourG3.new(params[:element_cour])
        element_cour.langue = @langue_active
       
        # lien
        formation = FormationG2.find(element_cour.formation_g2_id)
        element_cour.lien = "/" +  formation.reference  + element_cour.lien
        element_cour.reference = element_cour.lien


        if element_cour.save
          CmpPageDetail.map_routes
          flash[:notice] = t("GestionElementCours.msg.ajouter_avec_succes")

          redirect_to "/gestions/gestion_cours_videos/element_cours_manager/index/#{formation.id}"
        else
          flash[:notice] = t("GestionElementCours.msg.erreur_ajouter")
          new
          render :action => :new
        end

  end

  # Edition de la page
  def edit
    
    @page = ElementCourG3.new(:titre=>t("GestionElementCours.Pages.Update.titre"))
    @element_cour = ElementCourG3.find(params[:id])
    @formation = FormationG2.find(@element_cour.formation_g2_id)
    @langues_active = CmpLangue.liste_objt_langues_actives
  end
 # Mise à jour
  def update
    @element_cour = ElementCourG3.find(params[:id])
    if @element_cour.update_attributes(params[:element_cour])
      flash[:notice] = t("GestionElementCours.msg.editer_avec_succes")
      redirect_to "/gestions/gestion_cours_videos/element_cours_manager/index/#{@element_cour.formation_g2_id}"
    else
      render :action => :edit
    end
  end

  # Supprimer la page et ses pages traduit
  def delete
      page = ElementCourG3.find(params[:id])
      formation = FormationG2.find(page.formation_g2_id)
      if    ElementCourG3.destroy(page.id)
          flash[:notice] = t("GestionElementCours.msg.supprimer_avec_succes")
        else
        flash[:notice] = t("GestionElementCours.msg.erreur_de_suppression")
        end
      redirect_to "/gestions/gestion_cours_videos/element_cours_manager/index/#{formation.id}"
  end


   def move_up
    page = ElementCourG3.find(params[:id])
    page.move_up
    redirect_to :action=>:index,:id=> page.formation_g2_id
  end

  def move_down
    page = ElementCourG3.find(params[:id])
    page.move_down
    redirect_to :action=>:index,:id=> page.formation_g2_id
  end
 

#  # Traduction de la page
#  def traduir
#    @ref_langue = params[:lg]
#    @element_cour_p = ElementCourG3.find(params[:id])
#    @langue = CmpLangue.find_by_reference(@ref_langue)
#    @langues_active = CmpLangue.liste_objt_langues_actives
#    @traduction = true
#    if !@langue.nil?
#
#          @element_cour = ElementCourG3.find(:first,:conditions=>["ref_id = ? and langue = ?",params[:id],@ref_langue])
#
#
#          # Creation de la @element_cour si il nexiste pas
#          if @element_cour.nil?
#            @element_cour = ElementCourG3.new
#            @element_cour.lien = "/" + @ref_langue  +((@element_cour_p.lien=="/")?"":@element_cour_p.lien)
#            @element_cour.titre = ""
#            @element_cour.description = ""
#            @element_cour.mots_cle = ""
#            @element_cour.reference = @ref_langue  +"-" + @element_cour_p.reference
#            @element_cour.user_id = current_user.id
#            @element_cour.langue = @ref_langue
#            @element_cour.ref_id =  @element_cour_p.id
#            if @element_cour.save
#              flash[:notice] = t("GestionElementCours.msg.page_ajouter_avec_succes")
#              #Layout : c'est la premier article de la page
#              article_page = CmpArticle.find(:first,:conditions=>["cmp_page_id = #{@element_cour_p.id}"])
#              CmpArticle.add_article_to_page(article_page.ref_article_classe, @element_cour.id,article_page.id,@ref_langue)
#            else
#              flash[:notice] = t("GestionElementCours.msg.erreur_ajouter_page")
#            end
#          end
#          edit_seo = params[:edit_seo]
#          if edit_seo.nil?
#          redirect_to "/admin/article_manager/update/#{@element_cour_p.get_cmp_layout.id}?ref_langue=#{@ref_langue}"
#          else
#          redirect_to "/admin/pages_manager/edit/#{@element_cour_p.get_page_traduit(@ref_langue).id}"
#          end
#    else
#      raise "Langue n'existe pas"
#    end
#  end

 
end
