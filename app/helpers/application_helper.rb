# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
 def menu_membre(args={})
     # Data Menu
     id_menu = "menu_membre"
     liste_element = SerialisationUtil.load("#{RAILS_ROOT}/data_yml/composants_pages/menu/#{id_menu}.yml")


     if !has_role? :gestion_page_demo and current_user.roles != "super_admin"
     if !has_role? :presence   and current_user.roles != "super_admin"
       liste_element.each { |element|
         if element.code == "admin"
           liste_element.delete(element)
         end
       }
     end
     end

     # On ne peut pas test sur has_role : l'utilisateur current n'a pas de role gestion sites
     # Seulement l'utilisateur admin de l'application root ( manarati.net) qui a le doit d'avoir
     # le role gestion_compte_site
     if UserRole.find(:first, :conditions=>["nom = ?","gestion_compte_site"]).nil? or  CmpSite.find(:first,:conditions=>["user_id = ?",@current_user.id]).nil?

           liste_element.each { |element|
             if element.code == "mes_sites_web"
               liste_element.delete(element)
             end
           }
       
     end



     # Parametrage de CmpMenu
     args[:id_menu] = "submenu"
     args[:liste_element] =  liste_element
     
     args[:class] = "shadowed"
     cmp_menu(args)
  end
  
end
