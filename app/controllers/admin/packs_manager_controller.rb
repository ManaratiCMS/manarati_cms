class Admin::PacksManagerController < ApplicationControllerCoreAdmin
 layout "admin"
 def index
    @page.titre =  t("GestionPacks.Pages.Index.titre")
    @packs = CmpPack.find(:all)
 end


 def new
     @pack = CmpPack.new
 end


  def create
    pack = CmpPack.new(params[:pack])
    pack.cmp_photo = CmpPhoto.new(params[:cmp_photo])
    if pack.save
      flash[:notice] = t("GestionPacks.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionPacks.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @pack = CmpPack.find(params[:id])
    @pack.cmp_photo = CmpPhoto.new  if @pack.cmp_photo.nil?
  end

  def update
    @pack = CmpPack.find(params[:id])
    if @pack.cmp_photo.nil?
    @pack.cmp_photo = CmpPhoto.new
    @pack.save
    end
    @pack.cmp_photo.update_attributes(params[:cmp_photo])
    if @pack.update_attributes(params[:pack])
      flash[:notice] = t("GestionPacks.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end


  def delete
      theme = CmpPack.find(params[:id])
      if theme.destroy
        flash[:notice] = t("GestionCmpPacks.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionCmpPacks.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end
end
