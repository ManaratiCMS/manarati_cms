# To change this template, choose Tools | Templates
# and open the template in the editor.

class UrlManager
  def initialize
    
  end

  def self.get_lien_relatif_page(url)
    #suppression de http://
    url = url.gsub("http://", "")
   #  suppression de nom de doamine
   url = url.gsub(url.split("/")[0], "")
    url
  end

    
end
