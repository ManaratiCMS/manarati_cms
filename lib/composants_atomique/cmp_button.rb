# To change this template, choose Tools | Templates
# and open the template in the editor.

class CmpButton < CmpLienHttp
  attr_accessor :id_button
  def initialize(nom,titre,lien,id_button)
    @nom  = nom
    @titre = titre
    @lien = lien
    @id_button = id_button
    
  end
end
