module ComposantsAtomiques::CmpVideoElementCourHelper
  def cmp_video_element_cour(obj)


     if !@reference_objet.nil?
     element_cour = ElementCourG3.find_by_reference(@reference_objet)
     cmp_composants = CmpComposant.find(:all,:order=>"ordre",:conditions=>["element_cour_g3_id = ? and type_contenu = ?",element_cour.id,"video"])
     else
       element_cour = ElementCourG3.find(:first)
     cmp_composants = CmpComposant.find(:all,:order=>"ordre",:conditions=>["element_cour_g3_id = ? and type_contenu = ?",element_cour.id,"video"])

     end
     
    render :partial => "composants_atomiques/cmp_video_element_cour/cmp_video_element_cour", :locals => {:cmp_composants=>cmp_composants, :obj => obj}
  end

  def cmp_video_element_cour_form(obj)
      render :partial=>"/composants_atomiques/cmp_video_element_cour/cmp_video_element_cour_form",:locals=>{:obj=>obj}
  end
end
