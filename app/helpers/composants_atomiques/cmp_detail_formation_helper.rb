module ComposantsAtomiques::CmpDetailFormationHelper
  
  def cmp_detail_formation(obj)
    if obj.texte.blank?
      formation = FormationG2.find_by_reference(@reference_objet)
      if formation.nil?
        formation = FormationG2.find(:first)
      end
    else
      formation = FormationG2.find_by_reference(obj.texte)
    end

    plan_formations = PlanFormationG3.find(:all,:order=>"ordre",:conditions=>["formation_g2_id = ?",formation.id])
    session_formations = SessionG2.find(:all,:conditions=>["formation_g2_id = ?",formation.id])

    render :partial => "composants_atomiques/cmp_detail_formation/cmp_detail_formation", :locals => { :obj => obj ,:formation=>formation,:plan_formations=>plan_formations,:selected_element_cour=>0,:session_formations=>session_formations}
  end

  def cmp_detail_formation_form(obj)
    liste_formation = FormationG2.find(:all)
      render :partial=>"/composants_atomiques/cmp_detail_formation/cmp_detail_formation_form",:locals=>{:obj=>obj,:liste_formation=>liste_formation}
  end
end
