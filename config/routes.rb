ActionController::Routing::Routes.draw do |map|
#Manarati_CMS
map.connect 'images/:reference', :controller => 'system/multimedia', :action => 'image'

# Gestion des Membre Manarati
map.resource :account, :controller => "users"
map.resource :user_session
map.connect '/admin' , :controller => 'admin/bureau', :action => 'index'
map.connect '/manarati', :controller => 'administration', :action => 'index'

# Définition des lien Page et Page détail
begin
CmpPage.map_routes
rescue ActiveRecord::StatementInvalid
p "Pas de routage : la table CmpPage n'existe pas"
end
begin
CmpPageDetail.map_routes
rescue ActiveRecord::StatementInvalid
p "Pas de routage : la table CmpPageDetail n'existe pas"
end
 
# Gestion de Membre
map.connect 'sign_in' , :controller => '/bureau/authentication', :action => 'sign_in'
map.connect 'signed_out' , :controller => '/bureau/authentication', :action => 'signed_out'
map.connect 'change_password' , :controller => '/bureau/authentication', :action => 'change_password'
map.connect 'forgot_password' , :controller => '/bureau/authentication', :action => 'forgot_password'
map.connect 'new_user' , :controller => '/bureau/authentication', :action => 'new_user'
map.connect 'password_sent' , :controller => '/bureau/authentication', :action => 'password_sent'

# System ROR
map.connect ':controller/:action/:id'
map.connect ':controller/:action/:id.:format'
end
