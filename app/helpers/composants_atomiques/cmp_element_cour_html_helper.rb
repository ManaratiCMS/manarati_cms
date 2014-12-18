module ComposantsAtomiques::CmpElementCourHtmlHelper
  def cmp_element_cour_html(obj)

     if !@reference_objet.nil?
     element_cour = ElementCourG3.find_by_reference(@reference_objet)
     cmp_composants = CmpComposant.find(:all,:order=>"ordre",:conditions=>["element_cour_g3_id = ? and type_contenu = ?",element_cour.id,"html"])
     else
       element_cour = ElementCourG3.find(:first)
     cmp_composants = CmpComposant.find(:all,:order=>"ordre",:conditions=>["element_cour_g3_id = ? and type_contenu = ?",element_cour.id,"html"])

     end

    render :partial => "composants_atomiques/cmp_element_cour_html/cmp_element_cour_html", :locals => {:cmp_composants=>cmp_composants, :obj => obj }
  end

  def cmp_element_cour_html_form(obj)
      render :partial=>"/composants_atomiques/cmp_element_cour_html/cmp_element_cour_html_form",:locals=>{:obj=>obj}
  end
end
