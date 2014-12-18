# To change this template, choose Tools | Templates
# and open the template in the editor.

class MultimediaDataManager
  def initialize
    
  end

  def self.save_image(image_objet)
    SerialisationUtil.save("#{RAILS_ROOT}/data_yml/gestion_multimedia/contenu_media/images/instances/#{image_objet.reference}",image_objet)
  end

   def self.load_image(reference_image)
    @Objet =  SerialisationUtils.deserialiser("#{RAILS_ROOT}/data_yml/gestion_multimedia/contenu_media/images/instances/#{reference_image}")
    @Objet
  end

end
