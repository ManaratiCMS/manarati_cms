module ComposantsAtomiques::CmpPresentationVideoFormationHelper
  def cmp_presentation_video_formation(obj)
     if obj.texte.blank?
      formation = FormationG2.find_by_reference(@reference_objet)
      if formation.nil?
        formation = FormationG2.find(:first)
      end
    else
      formation = FormationG2.find_by_reference(obj.texte)
    end
     if !formation.cmp_animation_flash.nil? and  !formation.cmp_animation_flash.texte.nil?
    render :partial => "composants_atomiques/cmp_presentation_video_formation/cmp_presentation_video_formation", :locals => { :obj => formation }
     end
  end

  def cmp_presentation_video_formation_form(obj)
      render :partial=>"/composants_atomiques/cmp_presentation_video_formation/cmp_presentation_video_formation_form",:locals=>{:obj=>obj}
  end
end
