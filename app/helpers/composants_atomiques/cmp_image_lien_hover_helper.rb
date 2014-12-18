module ComposantsAtomiques::CmpImageLienHoverHelper
  def cmp_image_lien_hover_form(composant)
     render :partial=>"/composants_atomiques/cmp_image_lien_hover/cmp_image_lien_hover_form" ,:locals=>{:obj=>composant}
  end
  
  def cmp_image_lien_hover(composant)
    if !composant.nil?
      chemin_photo = "/media/images/#{composant.id}/#{composant.texte}"
      chemin_full_photo = "/media/images/#{composant.id}/origine/#{composant.texte}"
     render :partial=>"/composants_atomiques/cmp_image_lien_hover/cmp_image_lien_hover" ,:locals=>{:obj=>composant,:chemin_full_photo=>chemin_full_photo,:chemin_photo=>chemin_photo}
    end
  end
 

end
