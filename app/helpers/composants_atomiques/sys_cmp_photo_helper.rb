module ComposantsAtomiques::SysCmpPhotoHelper
  def sys_cmp_photo_form(composant)
     render :partial=>"/composants_atomiques/sys_cmp_photo/sys_cmp_photo_form" ,:locals=>{:obj=>composant}
  end
  # Params : alt = true
  def sys_cmp_photo_input(composant,args={})
     render :partial=>"/composants_atomiques/sys_cmp_photo/sys_cmp_photo_input" ,:locals=>{:obj=>composant,:args=>args}
  end

  def sys_cmp_photo(composant)
    if !composant.nil?
      chemin_photo = "/media/images_system/#{composant.id}/#{composant.texte}"
     render :partial=>"/composants_atomiques/sys_cmp_photo/sys_cmp_photo" ,:locals=>{:obj=>composant,:chemin_photo=>chemin_photo}
    end
  end

  def sys_cmp_photo_capture(composant)
    if !composant.nil? && !composant.texte.blank?
      chemin_photo = "/media/images_system/#{composant.id}/thumbnail_#{composant.texte}"
     render :partial=>"/composants_atomiques/sys_cmp_photo/sys_cmp_photo" ,:locals=>{:obj=>composant,:chemin_photo=>chemin_photo}
    end
  end
  def sys_cmp_photo_capture_avec_origin(composant)
    if !composant.nil? && !composant.texte.blank?
      chemin_photo = "/media/images_system/#{composant.id}/thumbnail_#{composant.texte}"
      chemin_origin = "/media/images_system/#{composant.id}/origine/#{composant.texte}"

     render :partial=>"/composants_atomiques/sys_cmp_photo/sys_cmp_photo_avec_origin" ,:locals=>{:chemin_origin => chemin_origin,:obj=>composant,:chemin_photo=>chemin_photo}
    end
  end
  def sys_cmp_photo_origine(composant)
    if !composant.nil? && !composant.texte.blank?
      chemin_photo = "/media/images_system/#{composant.id}/origine/#{composant.texte}"
     render :partial=>"/composants_atomiques/sys_cmp_photo/sys_cmp_photo_origine" ,:locals=>{:obj=>composant,:chemin_photo=>chemin_photo}
    end
  end



end
