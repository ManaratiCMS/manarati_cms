# To change this template, choose Tools | Templates
# and open the template in the editor.

class CmpPlanFormation < CmpPlan
  attr_accessor :liste_pages_formation
  def initialize
        @liste_element_plan = Array.new
        @liste_pages_formation = Array.new
        page_formation =   CmpPageFormation.new
        page_formation.code = "Formation 1"
        page_formation.description = "Description Page1"
        page_formation.mots_cles = "Mot Clé Formation"
        page_formation.reference = "page_1_formation"
        page_formation.titre = "Titre PageFoirmation"
        @liste_pages_formation << page_formation
  end
  def getPageParNumeroPage(numero_page)
    if numero_page.nil? or numero_page == 0
      numero_page = 1 # si le nupero de page n'exite pas , afficher l'element dans la premier page
    end
    indice = numero_page -1
    @liste_pages_formation[indice]
  end
end
