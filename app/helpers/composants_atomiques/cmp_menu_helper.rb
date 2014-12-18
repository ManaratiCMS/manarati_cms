module ComposantsAtomiques::CmpMenuHelper


  def cmp_menu(args={})
    id_menu = args[:id_menu]
    liste_element = args[:liste_element]
    style =  (args[:style].nil?)?"":args[:style]
    style += " "  + args[:class] if args[:class]
    render :partial => "composants_atomiques/cmp_menu/cmp_menu", :locals => {:id_menu=>id_menu, :menu => liste_element,:style=>style }
  end

 
  def cmp_menu_par_id(args={})
     id_menu = args[:id_menu]
     menu = SerialisationUtil.load("#{RAILS_ROOT}/data_yml/composants_pages/menu/#{id_menu}.yml")

     # Parametrage de CmpMenu
  
     args[:id_menu] = id_menu
     args[:liste_element] =  menu
     
     cmp_menu(args)

 
     
  end


  def cmp_menu_lib
     stylesheet_link_tag "themes/#{@skin}/composants/cmp_menu/cmp_menu"
     @cmp_style_lib =  stylesheet_link_tag "themes/#{@skin}/composants/cmp_menu/cmp_menu"
  end
 


end
