class AuteurG1 < ActiveRecord::Base
  belongs_to :cmp_photo,:dependent => :destroy
  def initialize(atributs=nil)
    super(atributs)
    self.cmp_photo = CmpPhoto.new
  end

  # Nom et Prénom de l'auteur
  def nom_complet
    self.nom + " " + self.prenom
  end
end
