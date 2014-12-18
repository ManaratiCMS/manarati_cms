# To change this template, choose Tools | Templates
# and open the template in the editor.

class DataComposantsManager
  def initialize
    
  end

  def self.save(composant_objet)
    File.open("#{RAILS_ROOT}/NativeData/data_composants/#{composant_objet.reference}", 'w+') do |file|
      file.puts YAML::dump(composant_objet)
    end
  end

   def self.load_composant(reference_data_composant)
    @Objet = nil
    File.open("#{RAILS_ROOT}/NativeData/data_composants/#{reference_data_composant}", 'r+') do |file|
      @Objet = YAML::load(file)
    end
    @Objet
  end


end
