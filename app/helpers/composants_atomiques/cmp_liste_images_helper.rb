module ComposantsAtomiques::CmpListeImagesHelper
  def cmp_liste_images(composant)
    if composant.sous_categorie.nil?
     images = ImageLibrary.find(:all,:conditions=>["categorie = ?",composant.categorie])
    else
     images = ImageLibrary.find(:all,:conditions=>["sous_categorie = ?",composant.sous_categorie])
    end
     render :partial => "composants_atomiques/cmp_liste_images/cmp_liste_images", :locals => { :obj => composant,:images=>images }
  end

  def cmp_liste_images_form(composant)
        @categories = CmpCategorie.find(:all,:conditions=>["cmp_categorie_id is null"])
     @sous_categories = CmpCategorie.find(:all,:conditions=>["cmp_categorie_id is not null"])

      render :partial=>"/composants_atomiques/cmp_liste_images/cmp_liste_images_form",:locals=>{:obj=>composant}
  end
end
