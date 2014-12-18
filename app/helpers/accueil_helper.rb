module AccueilHelper

#  def menu_principale(args={})
#     # Data Menu
#     id_menu = "menu_principale"
#     liste_element = SerialisationUtil.load("#{RAILS_ROOT}/data_yml/composants_pages/menu/#{id_menu}.yml")
#     # Autorization
#     liste_element.each { |item|
#       if item.code == "page_administration" and  !permitted_to? :index, :admin_bureau
#         liste_element.delete(item)
#       end
#     }
#     # Parametrage de CmpMenu
#     args[:id_menu] = id_menu
#     args[:liste_element] =  liste_element
#     cmp_menu(args)
#  end

 

 
end
