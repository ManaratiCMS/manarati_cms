class LivreG1 < ActiveRecord::Base
  belongs_to :cmp_photo,:dependent => :destroy
  belongs_to :auteur_g1
  def initialize(atributs=nil)
    super(atributs)
    self.cmp_photo = CmpPhoto.new
  end



end
