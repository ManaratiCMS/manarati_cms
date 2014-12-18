class Admin::LanguesManagerController < ApplicationControllerCoreAdmin
layout "admin"
def index
    @page.titre =  t("GestionLangues.Pages.Index.titre")
    @langues = CmpLangue.find(:all)
    @langues_actives = CmpLangue.langues_actives
 end




 def new
     @langue = CmpLangue.new
 end


  def create
    langue = CmpLangue.new(params[:langue])
    langue.sys_cmp_photo = SysCmpPhoto.new(params[:sys_cmp_photo])
    if langue.save
      flash[:notice] = t("GestionLangues.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionLangues.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @langue = CmpLangue.find(params[:id])
    @langue.sys_cmp_photo = SysCmpPhoto.new  if @langue.sys_cmp_photo.nil?
  end

  def update
    @langue = CmpLangue.find(params[:id])
    if @langue.sys_cmp_photo.nil?
    @langue.sys_cmp_photo = SysCmpPhoto.new
    @langue.save
    end
    @langue.sys_cmp_photo.update_attributes(params[:sys_cmp_photo])
    if @langue.update_attributes(params[:langue])
      flash[:notice] = t("GestionLangues.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      langue = CmpLangue.find(params[:id])
      if langue.destroy
        flash[:notice] = t("GestionLangues.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionLangues.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end
  
 # Activer une langue
 def activer
    langue = CmpLangue.find(params[:id])
    langue.activer()
     redirect_to :action=>:index
 end
 def setpublic
   langue = CmpLangue.find(params[:id])
   langue.protection = 1
   langue.save
   redirect_to :action=>:index
 end
 def setprivate
   langue = CmpLangue.find(params[:id])
   langue.protection = 0
   langue.save
   redirect_to :action=>:index
 end

 # Activer une langue pour l'utiliser
 def activer_langue
   langue = CmpLangue.find(params[:id])
    langue.activer_langue()
      redirect_to :action=>:index
 end
 # Desactiver une langue
 def desactiver_langue
   langue = CmpLangue.find(params[:id])
   langue.desactiver_langue()
   redirect_to :action=>:index
 end

end
