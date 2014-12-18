class Gestions::GestionContact::ContactManagersController < ApplicationControllerCoreAdmin
 layout "admin"

 def index
    @page.titre =  t("GestionContacts.Pages.Index.titre")
    @contacts = Contact.find(:all)
 end


 def new
     @contact = Contact.new
 end


  def create
    contact = Contact.new(params[:contact])
    if contact.save
      flash[:notice] = t("GestionContacts.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionContacts.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @contact = Contact.find(params[:id])
   end

  def update
    @contact = Contact.find(params[:id])



    if @contact.update_attributes(params[:contact])
      flash[:notice] = t("GestionContacts.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end

  def delete
      contact = Contact.find(params[:id])
      if contact.destroy
        flash[:notice] = t("GestionContacts.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionContacts.msg.erreur de suppression")
      end
      redirect_to :action=>:index
  end
  
end
