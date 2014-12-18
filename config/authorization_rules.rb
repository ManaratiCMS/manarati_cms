authorization do

  role :guest do
    # Gestion de Session :
    has_permission_on :user_sessions,:to=>[:destroy, :delete, :manage]
    # Affichage des Images
    has_permission_on :system_multimedia, :to => :image
    # Affichage des Article
    has_permission_on :system_articles, :to => [:afficher,:afficher_page_formation,:afficher_page_site_web]
    # Gestion de Formation 
    has_permission_on :system_page, :to => [:page_detail,:pajax]
    # Ajouter un Compte Site Startet ou pro
#    has_permission_on [:composants_atomiques_cmp_form_add_site], :to => [:add,:add_site]
    has_permission_on :administration, :to => :index
    # Inscription des utilisateur
    has_permission_on [:composants_atomiques_cmp_form_ajouter_utilisateur], :to => [:ajouter,:page_formulaire]
    # Bureau Virtuel
    has_permission_on :bureau_profile,:to=>[:index]
        # Inscription
    has_permission_on :users,:to=>[:login]
    has_permission_on :bureau_connect,:to=>[:index]
    has_permission_on :bureau_authentication,:to=>[:change_password,:sign_in,:login,:signed_out,:account_settings,:forgot_password]
  end
  role :super_admin do
    has_omnipotence
  end

  role :administrateur do
    has_permission_on :admin_bureau, :to => [:index]
  end

  # Gestion de FormationsG2
  role :gestion_formations_g2 do
     
    has_permission_on :gestions_gestion_formation_formation_manager, :to => [:index,:new,:create,:edit,:update,:delete,:move_up,:move_down,:setpublic,:setprivate]
    has_permission_on :gestions_gestion_formation_local_formation_manager, :to => [:index,:new,:create,:edit,:update,:delete]
    has_permission_on :gestions_gestion_formation_session_formation_manager, :to => [:index,:new,:create,:edit,:update,:delete]

  end
  # Gestion de Contacts
  role :gestion_contacts do
     has_permission_on :gestions_gestion_contact_contact_managers, :to => [:index,:new,:create,:edit,:update,:delete]
     has_permission_on :composants_atomiques_cmp_form_contact, :to => [:ajouter_contact]

  end
  # Gestion des ImageLibrary
  role :gestion_images_library do
     has_permission_on :gestions_gestion_images_library_images_librarys_managers, :to => [:index,:new,:create,:edit,:update,:delete]
  end

  # Gestion des Pages
  role :gestion_langues do
     has_permission_on :admin_layout_composants_manager, :to => [:traduir]
     has_permission_on :admin_menu_manager, :to => [:traduir,:edit_traduction]
  end

  # Gestion des Pages
  role :gestion_page_demo do
    includes :guest_demo
    has_permission_on :admin_pages_manager, :to => [:index,:new,:edit]   
    has_permission_on :admin_bureau, :to => [:index]
    has_permission_on :admin_article_manager, :to => [:update]
    
    has_permission_on :admin_article_manager, :to => [:ajouter_etape_2]
    has_permission_on :admin_article_manager, :to => [:ajouter_etape_3,:update,:supprimer,:move_up,:move_down]

  end
  role :gestion_page do
    includes :gestion_composant
    has_permission_on :admin_pages_manager, :to => [:index,:new,:create,:move_up,:move_down,:traduir]
    has_permission_on :admin_pages_manager, :to => [:edit,:update,:delete] 
    has_permission_on :admin_layout_composants_manager, :to => [:supprimer,:move_up,:move_down,:update,:ajouter,:ajouter_etape_2,:ajouter_etape_3] 
    has_permission_on :admin_compte, :to => [:edit,:update]
  end
   role :gestion_page_detail do
    includes :gestion_composant
    has_permission_on :admin_page_detail_manager, :to => [:index,:new,:create,:move_up,:move_down,:traduir]
    has_permission_on :admin_page_detail_manager, :to => [:edit,:update,:delete]
    has_permission_on :admin_layout_composants_manager, :to => [:supprimer,:move_up,:move_down,:update,:ajouter,:ajouter_etape_2,:ajouter_etape_3]
    has_permission_on :admin_compte, :to => [:edit,:update]
  end

  # Ajouter des Composant
  role :gestion_composant do
    has_permission_on :admin_article_manager, :to => [:ajouter_etape_2]
    has_permission_on :admin_article_manager, :to => [:ajouter_etape_3,:update,:supprimer,:move_up,:move_down] 
    has_permission_on :system_image, :to => [:upload_wysiswyg]
    has_permission_on :system_capture_mathe, :to => [:imagecapture]
  end
  role :gestion_formation do
    includes :gestion_composant
    has_permission_on [:admin_formation_manager], :to => [:index,:new,:create,:edit,:delete]
#    has_permission_on :admin_formation_manager, :to => [:edit,:delete] do
#      if_attribute :user_id => is {user.id}
#    end
    has_permission_on :admin_formation_page_manager, :to => [:new]
    has_permission_on :admin_formation_page_manager, :to => [:create,:update,:delete,:edit,:move_page_up,:move_page_down] do
     if_attribute :user_id => is {user.id}
    end
  end

  # Gestion de Menu
  role :gestion_menu do
   has_permission_on [:admin_menu_manager], :to => [:index,:new,:create]
   has_permission_on :admin_menu_manager, :to => [:delete,:edit,:update,:move_up,:move_down,:setpublic,:setprivate]
  end

  # Gestion de Themes
  role :gestion_themes do
    has_permission_on [:admin_themes_manager], :to => [:index,:activer]
  end
  # Gestions de Sites Web
  role :gestion_compte_site do
    has_permission_on [:admin_sites_manager], :to => [:index,:edit,:update,:delete,:send_welcome_email]
  end
  # Presentation : Gestion Page, Gestion Menu
  role :presence do
    has_permission_on [:admin_bureau], :to => [:index]
    includes :guest
    includes :gestion_page
    includes :gestion_menu
  end

  # Formateur : Gestion Formation, Gestion Page, Gestion Menu
  role :formateur do
    has_permission_on [:admin_bureau], :to => [:index]
    includes :guest
    includes :gestion_formation
    includes :gestion_page
    includes :gestion_menu
  end

  # Gestion des formations
  role :gestion_des_formations do
    has_permission_on [:admin_bureau], :to => [:index]
    includes :gestion_formation
  end

  role :gestion_membre do
    has_permission_on [:admin_users_manager], :to => [:index,:new,:edit]
  end
  role :gestion_partenaires do
    has_permission_on [:gestions_gestion_partenaires_admin_partenaires_managers], :to => [:index,:update,:new,:create,:edit,:delete]
  end
  role :gestion_element_cours do
    has_permission_on [:gestions_gestion_cours_videos_element_cours_manager], :to => [:index,:update,:new,:create,:edit,:delete,:move_up,:move_down]
    has_permission_on [:gestions_gestion_cours_videos_composants_element_cours_manager], :to => [:index,:ajouter_etape_2,:ajouter_etape_3,:new,:delete,:update,:move_up,:move_down]
  end
   role :gestion_plan_formation do
    has_permission_on [:gestions_gestion_cours_videos_plan_formation_manager], :to => [:index,:update,:new,:create,:edit,:delete,:move_up,:move_down,:init_ordre]
   end



  role :gestion_menus do
    has_permission_on [:gestions_gestion_menus_menu_manager], :to => [:index,:update,:new,:create,:edit,:delete,:move_up,:move_down]
    has_permission_on [:gestions_gestion_menus_elements_menu_manager], :to => [:index,:update,:new,:create,:edit,:delete,:move_up,:move_down]
  end
  role :gestion_utilisateurs do
       has_permission_on [:gestions_gestion_utilisateur_utilisateurs_manager], :to => [:index,:update,:new,:create,:edit,:delete]
  end
  role :gestion_formateurs do
       
       has_permission_on [:gestions_gestion_utilisateur_formateurs_manager], :to => [:index,:update,:new,:create,:edit,:delete]
  
  end
end


privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :gestion, :includes => [:index, :new, :add, :update]
  privilege :read, :includes => [:index,:afficher]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end


