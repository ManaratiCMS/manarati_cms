module ComposantsAtomiques::CmpMenuFixedFadeHelper
  def cmp_menu_fixed_fade(obj)
    render :partial => "composants_atomiques/cmp_menu_fixed_fade/cmp_menu_fixed_fade", :locals => { :obj => obj }
  end

  def cmp_menu_fixed_fade_form(obj)
      render :partial=>"/composants_atomiques/cmp_menu_fixed_fade/cmp_menu_fixed_fade_form",:locals=>{:obj=>obj}
  end
end
