# To change this template, choose Tools | Templates
# and open the template in the editor.

class ConfigCmp
  def initialize
    
  end

  # Chargement de fichier de configuration de composant atomique
  def self.chargement_fichier_configuration(theme,nom_fichier)
  if File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{theme}/articles/config/#{nom_fichier}")
    config = YAML::load(File.open("#{RAILS_ROOT}/public/stylesheets/themes/#{theme}/articles/config/#{nom_fichier}", "r"))
  else
   config = YAML::load(File.open("#{RAILS_ROOT}/public/stylesheets/themes/public_sys/articles/config/#{nom_fichier}", "r"))
  end
  return config

  end
end
