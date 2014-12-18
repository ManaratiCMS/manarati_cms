# To change this template, choose Tools | Templates
# and open the template in the editor.

class CmpPageManager
  def initialize
    
  end

  def self.save(page_objet)
    SerialisationUtil.save("#{RAILS_ROOT}/data_yml/data_pages/#{page_objet.reference}.yml", page_objet)
  end

   def self.load_page(reference_data_page)
     SerialisationUtil.load("#{RAILS_ROOT}/data_yml/data_pages/#{reference_data_page}.yml")
  end
end
