module ComposantsAtomiques::CmpTitreHelper
  def cmp_titre_form(obj_cmp_titre)
     valeur_font = CmpTitre.get_config["type"]
    
     render :partial=>"/composants_atomiques/cmp_titre/cmp_titre_form" ,:locals=>{:obj_cmp_titre=>obj_cmp_titre,:valeur_font => valeur_font}
  end
  def cmp_titre(composant)
      chemin_titre = "/media/images/#{composant.id}/#{composant.texte}.png"
      view_render = CmpTitre.get_config["view"]
      if view_render.nil?
        render :partial=>"/composants_atomiques/cmp_titre/cmp_titre" ,:locals=>{:chemin_titre=>chemin_titre,:obj=>composant}
      else
            render :partial=> view_render ,:locals=>{:chemin_titre=>chemin_titre,:obj=>composant}

      end
  end
end
