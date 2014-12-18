module ComposantsAtomiques::CmpMenuPrincipaleHelper


  
  def cmp_menu_principale(menu_liens,reference_page_active)
    render :partial => "composants_atomiques/cmp_menu_principale/cmp_menu_principale", :locals => { :menu_liens => menu_liens,:reference_page_active=> reference_page_active }
  end

end
