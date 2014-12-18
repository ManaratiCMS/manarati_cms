module ComposantsAtomiques::CmpLayout2ColoneEgauxHelper
  def cmp_layout2_colone_egaux_form(composant)
     config =   ConfigCmp.chargement_fichier_configuration(@skin_public, "cmp_layout2_colone_egaux.yml")
     render :partial=>"/composants_atomiques/cmp_layout2_colone_egaux/cmp_layout2_colone_egaux_form" ,:locals=>{:obj=>composant,:config=>config}
  end
  def cmp_layout2_colone_egaux(composant)
     render :partial=>"/composants_atomiques/cmp_layout2_colone_egaux/cmp_layout2_colone_egaux" ,:locals=>{:obj=>composant,:articles=>composant.cmp_article.cmp_articles}
  end
end
