module ComposantsSite::MenuConnexionHelper

  def menu_connexion
     menu_connexion = SerialisationUtil.load("#{RAILS_ROOT}/data_yml/composants_pages/caneva_generale/menu_connexion.yml")
     render :partial=>"/composants_site/menu_connexion", :locals => { :menu => menu_connexion ,:id_menu=>"menu_connexion"}
  end

end
