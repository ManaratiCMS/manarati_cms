module ComposantsAtomiques::CmpMenuAccueilHelper
  def cmp_menu_accueil(obj)
    menu = MenuG4.find(obj.texte.to_i)
    if !menu.element_menu_g4.nil?
    render :partial => "composants_atomiques/cmp_menu_accueil/cmp_menu_accueil", :locals => { :obj => obj ,:menu=>menu}
    end
  end

  def cmp_menu_accueil_form(obj)
    liste_menu = MenuG4.find(:all,:order=>"ordre")
    render :partial=>"/composants_atomiques/cmp_menu_accueil/cmp_menu_accueil_form",:locals=>{:obj=>obj,:liste_menu=>liste_menu}
  end
end
