module ComposantsAtomiques::CmpFormationSliderHelper
  def cmp_formation_slider(obj)
    formations = FormationG2.find(:all)
    
    render :partial => "composants_atomiques/cmp_formation_slider/cmp_formation_slider", :locals => { :obj => obj ,:formations=>formations}
  end

  def cmp_formation_slider_form(obj)
      render :partial=>"/composants_atomiques/cmp_formation_slider/cmp_formation_slider_form",:locals=>{:obj=>obj}
  end
end
