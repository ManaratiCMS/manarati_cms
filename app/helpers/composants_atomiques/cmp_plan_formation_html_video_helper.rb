module ComposantsAtomiques::CmpPlanFormationHtmlVideoHelper
  def cmp_plan_formation_html_video(obj)
 
    selected_element_cour = 0
    if !@reference_objet.nil?
        if @type_objet == "FormationG2"
              # Utilisation de reference de Formation de la page DétailFormation
              formation = FormationG2.find_by_reference(@reference_objet)
              plan_formations = PlanFormationG3.find(:all,:order=>"ordre",:conditions=>["formation_g2_id = ?",formation.id])
        elsif @type_objet == "ElementCourG3"
              element_cour = ElementCourG3.find_by_reference(@reference_objet)
              formation = element_cour.formation_g2
              plan_formations = PlanFormationG3.find(:all,:order=>"ordre",:conditions=>["formation_g2_id = ?",element_cour.formation_g2_id])
              selected_element_cour = element_cour.id
        end
    else
       # en Cas d'erreur Affichage de la premier formation
           formation = FormationG2.find(:first)
           plan_formations = PlanFormationG3.find(:all,:order=>"ordre",:conditions=>["formation_g2_id = ?",formation.id])
    end
    render :partial => "composants_atomiques/cmp_plan_formation_html_video/cmp_plan_formation_html_video", :locals => { :plan_formations=>plan_formations,:obj => obj,:formation=>formation,:selected_element_cour=>selected_element_cour }
  end

  def cmp_plan_formation_html_video_form(obj)
      render :partial=>"/composants_atomiques/cmp_plan_formation_html_video/cmp_plan_formation_html_video_form",:locals=>{:obj=>obj}
  end
end
