module ComposantsAtomiques::CmpResumeDetailFormationHelper
  def cmp_resume_detail_formation(obj)
     if obj.texte.blank?
      formation = FormationG2.find_by_reference(@reference_objet)
      if formation.nil?
        formation = FormationG2.find(:first)
      end
    else
      formation = FormationG2.find_by_reference(obj.texte)
    end
    render :partial => "composants_atomiques/cmp_resume_detail_formation/cmp_resume_detail_formation", :locals => { :obj => obj,:formation=>formation }
  end

  def cmp_resume_detail_formation_form(obj)
      render :partial=>"/composants_atomiques/cmp_resume_detail_formation/cmp_resume_detail_formation_form",:locals=>{:obj=>obj}
  end
end
