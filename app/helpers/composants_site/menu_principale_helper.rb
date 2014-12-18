module ComposantsSite::MenuPrincipaleHelper


  # Menu Principale de Site Web
  # affichage de menu
  # max = le nombre maximale de lien à afficher
  # radius = l'ajout de deux div bg_menu_p1 et bg_menu_p3
  def menu_site_web(max = nil)
   menu_principale(max,false,false)
  end

  def menu_principale_radius(max = nil)
    menu_principale(max,true,false)
  end
  def menu_principale_avec_separator(max = nil)
     menu_principale(max,false,true)
  end


  def menu_principale(max,radius,separateur)
   
     if max.nil?
     liens = CmpMenu.find(:all,:order => "ordre",:conditions=>["protection = 1 and ref_langue = ?",@page.langue])
     else
     liens = CmpMenu.find(:all,:order => "ordre",:limit =>max,:conditions=>["protection = 1 and ref_langue = ?",@page.langue])
     end
     liens = Array.new if liens.nil?
     
     id_menu = "menu_principale"

     if radius
     render :partial => "composants_site/menu_principale_radius", :locals => {:id_menu=>id_menu, :liste_lien => liens,:separateur=>separateur}
     else
     render :partial => "composants_site/menu_principale", :locals => {:id_menu=>id_menu, :liste_lien => liens,:separateur=>separateur}
     end
     
   
  end



  #  def menu_principale(code_page)
#    @menu_lien = SerialisationUtils.deserialiser("#{RAILS_ROOT}/NativeData/data_composants/menu_principale.yml")
#    cmp_menu_principale(@menu_lien,code_page)
#  end

  def menu_principale_library
     stylesheet_link_tag "themes/#{@skin}/composants/cmp_menu_principale/cmp_menu_principale_1"
  end


end
