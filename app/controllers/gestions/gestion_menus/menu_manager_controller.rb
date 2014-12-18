class Gestions::GestionMenus::MenuManagerController < ApplicationControllerCoreAdmin
 layout "admin"
 def index
    @page.titre =  t("GestionMenuG4.Pages.Index.titre")
    @menus = MenuG4.find(:all,:order=>"ordre")
 end


 def new
     @menu = MenuG4.new
 end


  def create
    menu = MenuG4.new(params[:menu])
    menu.langue = "fr"
    if menu.save
      flash[:notice] = t("Gestions.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("Gestions.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @menu = MenuG4.find(params[:id])
  end

  def update
    @menu = MenuG4.find(params[:id])
    if @menu.update_attributes(params[:menu])
      flash[:notice] = t("Gestions.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      menu = MenuG4.find(params[:id])
       if  MenuG4.destroy(params[:id])
        flash[:notice] = t("Gestions.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("Gestions.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end


  def move_up
    menu = MenuG4.find(params[:id])
    menu.move_up
    redirect_to :action=>:index
  end

  def move_down
    menu = MenuG4.find(params[:id])
    menu.move_down
    redirect_to :action=>:index
  end

end
