class Admin::MenuManagerController < ApplicationControllerCoreAdmin
 layout "admin"
 filter_access_to [:delete,:edit,:update] ,:model=>:cmp_menu,:attribute_check=>true,:load_method => lambda { CmpMenu.find(params[:id]) }

 def index
    @page.titre =  t("GestionMenus.Pages.Index.titre")
    @menus = CmpMenu.find(:all,:conditions=>["ref_langue = ?",@langue_principale],:order => "ordre")
    @langues_active = CmpLangue.langues_actives
 end
 


 def new
     @menu = CmpMenu.new
     @pages = CmpPage.find(:all,:order=>"id",:conditions=>["formation_id is NULL and langue = ?",@langue_principale])
 end


  def create
    menu = CmpMenu.new(params[:menu])
    menu.user_id = current_user.id
    menu.ref_langue = @langue_principale
    if menu.save
      flash[:notice] = t("GestionMenus.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionMenus.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @menu = CmpMenu.find(params[:id])
    @pages = CmpPage.find(:all,:order=>"id",:conditions=>["formation_id is NULL  and langue = ?",@langue_principale])
  end

  def edit_traduction
    @menu = CmpMenu.find(params[:id])
    @menu_lg_princiaple = CmpMenu.find(@menu.ref_id)
  end

  def update
    @menu = CmpMenu.find(params[:id])

    if @menu.update_attributes(params[:menu])
      
      flash[:notice] = t("GestionMenus.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
           flash[:notice] = t("GestionMenus.msg.erreur_edition")
      redirect_to :action=>:index
    end
  end

  def traduir
    ref_langue = params[:lg]
    element_menu = CmpMenu.find(params[:id])
    element_menu_lg = CmpMenu.find(:first,:conditions=>["ref_id = ? and ref_langue = ?",element_menu.id,ref_langue])
    if element_menu_lg.nil? and !element_menu.cmp_page.nil?
      # Creation de l'objet element_menu_lg
      page_traduit = element_menu.cmp_page.get_page_traduit(ref_langue)
      if page_traduit.nil?
         flash[:notice] = t("GestionMenus.msg.page_en_cour_traduction")
         redirect_to :action=>:index
      else
      element_menu_lg = CmpMenu.new
      element_menu_lg.lien = page_traduit.lien
      element_menu_lg.titre = page_traduit.titre
      element_menu_lg.ordre = element_menu.ordre
      element_menu_lg.ref_id = element_menu.id
      element_menu_lg.ref_langue = ref_langue
      element_menu_lg.save
      end
    
    end

     redirect_to "/admin/menu_manager/edit_traduction/#{element_menu_lg.id}" if !element_menu_lg.nil?

    
  end

  def delete
      if CmpMenu.destroy(params[:id])
        flash[:notice] = t("GestionMenus.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionMenus.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end

  def move_up
    menu = CmpMenu.find(params[:id])
    menu.move_up
    redirect_to :action=>:index
  end

  def move_down
    menu = CmpMenu.find(params[:id])
    menu.move_down
    redirect_to :action=>:index
  end


  def setpublic
   menu = CmpMenu.find(params[:id])
   menu.set_public
   redirect_to :action=>:index
 end
 def setprivate
   menu = CmpMenu.find(params[:id])
   menu.set_private
   redirect_to :action=>:index
 end


 
end
