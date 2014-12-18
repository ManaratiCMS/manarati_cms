module ComposantsAtomiques::CmpPhotoHelper
  def cmp_photo_form(composant)
     render :partial=>"/composants_atomiques/cmp_photo/cmp_photo_form" ,:locals=>{:obj=>composant}
  end
  # Params : alt = true
  def cmp_photo_input(composant,args={})
     render :partial=>"/composants_atomiques/cmp_photo/cmp_photo_input" ,:locals=>{:obj=>composant,:args=>args}
  end

  def cmp_photo(composant)
    if !composant.nil?
      chemin_photo = "/media/images/#{composant.id}/#{composant.texte}"
       chemin_full_photo = "/media/images/#{composant.id}/origine/#{composant.texte}"
     render :partial=>"/composants_atomiques/cmp_photo/cmp_photo" ,:locals=>{:obj=>composant,:chemin_full_photo=>chemin_full_photo,:chemin_photo=>chemin_photo}
    end
  end
 def cmp_photo_sans_lien(composant)
    if !composant.nil?
      chemin_photo = "/media/images/#{composant.id}/#{composant.texte}"
      chemin_full_photo = "/media/images/#{composant.id}/origine/#{composant.texte}"
     render :partial=>"/composants_atomiques/cmp_photo/cmp_photo_capture_sans_lien" ,:locals=>{:obj=>composant,:chemin_full_photo=>chemin_full_photo,:chemin_photo=>chemin_photo}
    end
  end

  def cmp_photo_capture(composant)
    if !composant.nil? && !composant.texte.blank?
      chemin_photo = "/media/images/#{composant.id}/thumbnail_#{composant.texte}"
      chemin_full_photo = "/media/images/#{composant.id}/origine/#{composant.texte}"
     render :partial=>"/composants_atomiques/cmp_photo/cmp_photo_capture" ,:locals=>{:obj=>composant,:chemin_full_photo=>chemin_full_photo,:chemin_photo=>chemin_photo}
    end
  end
  def cmp_photo_capture_sans_lien(composant)
    if !composant.nil? && !composant.texte.blank?
      chemin_photo = "/media/images/#{composant.id}/thumbnail_#{composant.texte}"
     render :partial=>"/composants_atomiques/cmp_photo/cmp_photo_capture_sans_lien" ,:locals=>{:obj=>composant,:chemin_photo=>chemin_photo}
    end
  end




end
