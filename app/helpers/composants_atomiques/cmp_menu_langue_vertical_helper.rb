module ComposantsAtomiques::CmpMenuLangueVerticalHelper
  def cmp_menu_langue_vertical(composant)
    pages = @page.get_pages_langue
    render :partial => "composants_atomiques/cmp_menu_langue_vertical/cmp_menu_langue_vertical", :locals => { :obj => composant,:pages=>pages }
  end

  def cmp_menu_langue_vertical_form(composant)
      render :partial=>"/composants_atomiques/cmp_menu_langue_vertical/cmp_menu_langue_vertical_form",:locals=>{:composant=>composant}
  end

  def cmp_menu_langue
    pages = @page.get_pages_langue
    render :partial => "composants_atomiques/cmp_menu_langue_vertical/cmp_menu_langue", :locals => { :pages=>pages }
  end
end
