module ComposantsAtomiques::CmpBarMenuElementCourHelper

  def cmp_bar_menu_element_cour(obj)
     if !@reference_objet.nil?
     element_cour = ElementCourG3.find_by_reference(@reference_objet)
     else
     element_cour = ElementCourG3.find(:first)
     end
    render :partial => "composants_atomiques/cmp_bar_menu_element_cour/cmp_bar_menu_element_cour", :locals => { :obj => obj,:element_cour=>element_cour }
  end

  def cmp_bar_menu_element_cour_form(obj)
      render :partial=>"/composants_atomiques/cmp_bar_menu_element_cour/cmp_bar_menu_element_cour_form",:locals=>{:obj=>obj}
  end
end
