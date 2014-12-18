# To change this template, choose Tools | Templates
# and open the template in the editor.

class CmpElementPlanFormation < CmpElementPlan
  attr_accessor :avoire_article,:numero_page
  attr_accessor :rubrique,:fils,:reference_article
  def initialize(atributs=nil)
    if !atributs.nil?
      @nom = atributs[:nom]
      @titre = atributs[:titre]
      @reference_article = atributs[:reference_article]
      @numero_page = 1
      @code =  atributs[:code]
    end
  end
end
