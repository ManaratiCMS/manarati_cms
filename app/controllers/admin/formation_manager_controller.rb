# Gestion des Formation 
class Admin::FormationManagerController < ApplicationControllerCoreAdmin
  layout "admin"
  #filter_access_to :edit,:delete ,:model=>:formation,:attribute_check=>true,:load_method => lambda { Formation.find(params[:id]) }
  # Affichage de Toutes les Formation
  def index
    @page = CmpPage.new(:titre=>t("GestionFormations.titre_de_gestion"))
    if current_user.roles != "super_admin"
    @formations = Formation.find(:all)
    else
    @formations = Formation.find(:all)
    end
  end

  #Formulaire d'Ajouter une nouvelle formation
  def new
     @formation = Formation.new
     @formateurs = User.find(:all,:conditions => "login != 'root'")
  end

# Création de la formation
  def create
    formation = Formation.new(params[:formation])
    formation.cmp_photo = CmpPhoto.new(params[:cmp_photo])
    if formation.save
      flash[:notice] = t("GestionFormations.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionFormations.msg.erreur_ajouter")
      render :action => :new
    end
  end


  # Formulaire d'editer une formation
  def edit
    @formation = Formation.find(params[:id])
    @formation.cmp_photo = CmpPhoto.new  if @formation.cmp_photo.nil?
    @formateurs = User.find(:all,:conditions => "roles = 'formateur'")
  end

  # Mise à jour d'une formation
  def update
    @formation = Formation.find(params[:id])
    if @formation.cmp_photo.nil?
    @formation.cmp_photo = CmpPhoto.new 
    @formation.save
    end
    @formation.cmp_photo.update_attributes(params[:cmp_photo])
    @formation.update_formateur(params[:formation][:user_id])
    if @formation.update_attributes(params[:formation])
      flash[:notice] = t("GestionFormations.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end


  def delete
      formation = Formation.find(params[:id])
      if formation.destroy
        flash[:notice] = t("GestionFormations.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionFormations.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end

#  # Action Supprimer une formation
#  def supprimer
#      @Formation = Formation.find(params[:id])
#      # il faut suppromer le repertoire contenant le plan de formation
#      index
#      render :action=>:index
#  end
#
#  # Modifier une formation
#  def modifier
#    if params[:formation].blank?
#      @formation = Formation.find(params[:id])
#    else
#      if !params[:id].blank?
#      Formation.update(params[:id], params[:formation])
#      else
#        formation = Formation.new(params[:formation])
#       if formation.save
#         # Creation de Plan de formation
#
#         Dir.mkdir("#{RAILS_ROOT}/data_yml/gestion_formations/#{formation.reference}")
#         plan_foramtion = CmpPlanFormation.new
#         SerialisationUtil.save("#{RAILS_ROOT}/data_yml/gestion_formations/#{formation.reference}/plan_formation.yml", plan_foramtion)
#       end
#
#      end
#      index
#      render :action=>:index
#    end
#  end
#
#  #
#  # Gestion de Plan de Formation
#  #
#
#  # Modifier le niveau de l'element_plan dans le plan de dormartion
#  # 4 type de modification , movement en haut , en bas, à droit et à gauche
#  def modier_niveau_element_plan
#   # Action : haut, bas ,droit , gauche
#   @formation = Formation.find(params[:id])
#   @formation.plan_deplacer(params[:ref_element_plan],params[:type_action])
#   modifier
#   render :action=>:modifier
#  end
#
#  # Ajouter et Update un element dans le plan de formation
#  def ajouter_element_plan
#    # dans le cas de reçoi une redirection
#    if !params[:sender_id].nil?
#       params[:id] = params[:sender_id].split("_")[0]
#      params[:ref_element] = params[:sender_id].split(   params[:id] + "_")[1]
#
#
#      enregistrer_element_plan
#    end
#
#    if !params[:ref_element].blank?
#      # le cas de Update
#      @ref_element = params[:ref_element]
#      @id_formation = params[:id]
#      formation = Formation.find(@id_formation)
#      @element_plan = formation.get_element_plan_par_ref(@ref_element)
#    else
#      # le Cas d'ajouter
#      @ref_element_frere = params[:ref_element_frere]
#      @id_formation = params[:id]
#      @element_plan = CmpElementPlanFormation.new
#    end
#  end
#
#  # Supprimer un element de plan de formation
#  def supprimer_element_plan
#    ref_element = params[:ref_element]
#    formation = Formation.find(params[:id])
#    formation.supprimer_dans_plan(ref_element)
#    params[:id] = formation.id
#    modifier
#    render :action=>:modifier
#  end
#
#  # Ajoutet et Modifer un element de plan de formation
#  def modifier_element_plan
#
#    # Compléter l'ajout d'un element de plan par l'ajout de l'article
#    if !params[:sender_id].blank? and !params[:ref_article].blank?
#      id_formation = params[:sender_id].split("_")[0]
#      ref_element_formation = params[:sender_id].split(  id_formation + "_")[1]
#      formation = Formation.find(id_formation)
#      element_plan = formation.get_element_plan_par_ref(ref_element_formation)
#      element_plan.reference_article = params[:ref_article]
#      formation.update_element_plan(element_plan)
#
#      params[:id] = formation.id
#      modifier
#      render :action=>:modifier
#    elsif !params[:ref_element].blank?
#      # Update d'un element de plan
#
#
#      # Je sui charger l'elemet_plan de la base de donnée et apres je fait la modification
#      # et aprés je enregistre l'information
#      ref_element = params[:ref_element]
#      element_plan = CmpElementPlanFormation.new(params[:element_plan])
#
#      formation = Formation.find(params[:id_formation])
#      formation.update_element_plan(element_plan)
#      params[:id] = formation.id
#      @formation  = formation
#      modifier
#      render :action=>:modifier
#    else !params[:ref_element_frere].blank?
#      ref_element_frere = params[:ref_element_frere]
#      element_plan = CmpElementPlanFormation.new(params[:element_plan])
#      formation = Formation.find(params[:id_formation])
#      formation.ajouter_dans_plan(element_plan, ref_element_frere)
#      # ajouter l'article s'il n'existe pas
##      if params[:element_plan][:reference_article].blank?
##        redirect_to "/admin/article_manager/ajouter?sender_url=/admin/formation_manager/modifier_element_plan&sender_id=#{params[:id_formation]}_#{params[:element_plan][:code]}"
##      else
#        params[:id] = formation.id
#        modifier
#        render :action=>:modifier
##      end
#    end
#
#
#
#
#  end
#
#
#
#    def enregistrer_element_plan
#      ref_element = params[:ref_element]
#      id_formation = params[:id]
#
#      formation = Formation.find(id_formation)
#      element_plan = formation.get_element_plan_par_ref(ref_element)
#
#      # La liste des article
#      ref_pocesseur = "formation_" + id_formation + "_" + ref_element
#      liste_article = CmpArticle.find(:all,:conditions => "ref_pocesseur='#{ref_pocesseur}'").collect { |article|  article.id }
#      element_plan.reference_article =  liste_article
#      formation.update_element_plan(element_plan)
#
##      params[:id] = formation.id
##      modifier
##      render :action=>:modifier

#    end
end
