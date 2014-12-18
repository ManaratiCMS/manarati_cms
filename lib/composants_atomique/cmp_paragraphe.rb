# To change this template, choose Tools | Templates
# and open the template in the editor.

class CmpParagraphe < CmpText
  attr_accessor :label_form
  attr_accessor :type_composant

  after_save { |i|
   # Déplacement des images Ajouter dans le paragraphe en utilisation de
   # WYSISWYG, vers son emplacement
   # media/images/ id_composant /imgw

   # Recherche de tous les balise <img src="" />


  }


  def initialize(atributs=nil)
    @type_composant = "paragraphe"
    super(atributs)
    if !atributs.nil?
    @label_form = atributs[:label_form] if !atributs[:label_form].nil?
    end
  end


end
