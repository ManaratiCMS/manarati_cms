# To change this template, choose Tools | Templates
# and open the template in the editor.

class Image
  attr_accessor :reference,:nom,:text_alt,:width,:height,:reference_image,:type_image
  def initialize
    
  end

  def image_path
    path = "#{RAILS_ROOT}/data_yml/gestion_multimedia/contenu_media/images/images/#{self.reference_image}/#{self.reference_image}.#{self.type_image}"
    path
  end
end
