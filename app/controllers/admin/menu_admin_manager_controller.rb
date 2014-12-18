class Admin::MenuAdminManagerController < ApplicationControllerCoreAdmin
 layout "admin"
 def index
    @page.titre =  t("GestionMenus.Pages.Index.titre")
    @menus = CmpMenuAdmin.find(:all,:order => "ordre")
 end
 
 def new
     @menu = CmpMenuAdmin.new
     @packs = CmpPack.find(:all)
 end


  def create
    menu = CmpMenuAdmin.new(params[:menu])
    if menu.save
      flash[:notice] = t("GestionMenus.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionMenus.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @menu = CmpMenuAdmin.find(params[:id])
     @packs = CmpPack.find(:all)
  end


  def update
    @menu = CmpMenuAdmin.find(params[:id])
    if @menu.update_attributes(params[:menu])
      flash[:notice] = t("GestionMenus.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      if CmpMenuAdmin.destroy(params[:id])
        flash[:notice] = t("GestionMenus.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionMenus.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end

  def move_up
    menu = CmpMenuAdmin.find(params[:id])
    menu.move_up
    redirect_to :action=>:index
  end

  def move_down
    menu = CmpMenuAdmin.find(params[:id])
    menu.move_down
    redirect_to :action=>:index
  end


end
