# To change this template, choose Tools | Templates
# and open the template in the editor.

class ArticleType < Article
  attr_accessor :reference,:fichier_css,:fichier_js,:cmp_composants
  attr_accessor :ref_image_capture,:nom,:description,:fichier_js,:fichier_css
  attr_accessor :libs_css,:libs_js
  def initialize(reference)
    @reference = reference
#    @ref_image_capture = "capture_article_type_1"
  end
end
