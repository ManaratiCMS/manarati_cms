# To change this template, choose Tools | Templates
# and open the template in the editor.

class SerialisationUtil
  def initialize
    
  end

  def self.load(chemin_fchier_yml)
   objet = YAML::load(File.open(chemin_fchier_yml, "r"))
   objet
  end

  def self.save(chemin_fchier_yml,objet)
    File.open(chemin_fchier_yml, "w") do |file|
        file.puts YAML::dump(objet)
    end
  end

   def self.supprimer(chemin_fchier_yml)
     if File.exist?(chemin_fchier_yml)
     File.delete(chemin_fchier_yml)
     end
  end

end
