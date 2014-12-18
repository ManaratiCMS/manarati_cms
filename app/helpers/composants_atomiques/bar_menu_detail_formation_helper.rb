module ComposantsAtomiques::BarMenuDetailFormationHelper
  def bar_menu_detail_formation(obj)
    render :partial => "composants_atomiques/bar_menu_detail_formation/bar_menu_detail_formation", :locals => { :obj => obj }
  end

  def bar_menu_detail_formation_form(obj)
      render :partial=>"/composants_atomiques/bar_menu_detail_formation/bar_menu_detail_formation_form",:locals=>{:obj=>obj}
  end
end
