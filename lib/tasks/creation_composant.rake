
  desc "Creation d'un composants atomique"
  task :creation_composant_atomique , :nom do |t, args|
    
    nom = args["nom"]

# ---------------------------------------
# Création de Répertoire de composants
# -----------------------------------------
#    Création de Répertoire composant dans  Helper
  if !File.exists?("#{RAILS_ROOT}/app/helpers/composants")
        puts "{RAILS_ROOT}/app/helpers/composants n'existe pas, nous le créons donc"
        Dir.mkdir "#{RAILS_ROOT}/app/helpers/composants"
  end
#  Création de Répertoire composant dans View
  if !File.exists?("#{RAILS_ROOT}/app/views/composants")
        puts "{RAILS_ROOT}/app/views/composants n'existe pas, nous le créons donc"
        Dir.mkdir "#{RAILS_ROOT}/app/views/composants"
  end
#  Création de Répertoire composants dans javascript
  if !File.exists?("#{RAILS_ROOT}/public/javascripts/composants")
        puts "#{RAILS_ROOT}/public/javascripts/composants n'existe pas, nous le créons donc"
        Dir.mkdir "#{RAILS_ROOT}/public/javascripts/composants"
  end
#  Création de Répertoire composants dans stylesheet
  if !File.exists?("#{RAILS_ROOT}/public/stylesheets/themes/default/composants")
        puts "#{RAILS_ROOT}/public/stylesheets/themes/default/composants n'existe pas, nous le créons donc"
        Dir.mkdir "#{RAILS_ROOT}/public/stylesheets/themes/default/composants"
  end
# -------------------------------------------------------------------------





  end


