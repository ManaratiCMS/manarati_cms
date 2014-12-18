module ComposantsAtomiques::CmpSliderPresentationHelper
  def cmp_slider_presentation(obj)

    eval "@liste_source_data  = #{obj.texte}.get_liste_obj_data_source"



    render :partial => "composants_atomiques/cmp_slider_presentation/cmp_slider_presentation", :locals => { :obj => obj ,:liste_source_data=>@liste_source_data}
  end

  def cmp_slider_presentation_form(obj)
      sources = Array.new
      sources << ["Formations","FormationG2"] if has_role? :gestion_formations_g2
      sources << ["Image","ImageLibrary"] if has_role? :gestion_images_library
      render :partial=>"/composants_atomiques/cmp_slider_presentation/cmp_slider_presentation_form",:locals=>{:obj=>obj,:sources=>sources}
  end
end
