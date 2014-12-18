# To change this template, choose Tools | Templates
# and open the template in the editor.

class SerialisationUtils
  def initialize
    
  end

  def self.serialiser(chemin,objet)
    File.open(Chemin, 'w+') do |file|
      file.puts YAML::dump(objet)
    end
  end

  


  def self.deserialiser(chemin)
    objet = nil
     File.open(chemin, 'r+') do |file|
      objet = YAML::load(file)
    end
    objet
  end
end
