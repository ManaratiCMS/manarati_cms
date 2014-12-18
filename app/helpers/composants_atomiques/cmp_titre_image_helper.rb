module ComposantsAtomiques::CmpTitreImageHelper
  def cmp_titre_image_form(composant)
     render :partial=>"/composants_atomiques/cmp_titre_image/cmp_titre_image_form" ,:locals=>{:obj=>composant}
  end


  def cmp_titre_image(composant)
    if !composant.nil?
      chemin_photo = "/media/images/#{composant.id}/#{composant.texte}"
      chemin_full_photo = "/media/images/#{composant.id}/origine/#{composant.texte}"
     render :partial=>"/composants_atomiques/cmp_titre_image/cmp_titre_image" ,:locals=>{:obj=>composant,:chemin_full_photo=>chemin_full_photo,:chemin_photo=>chemin_photo}
    end
  end
 

end
