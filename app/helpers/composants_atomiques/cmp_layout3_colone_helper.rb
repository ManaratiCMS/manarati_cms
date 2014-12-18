module ComposantsAtomiques::CmpLayout3ColoneHelper


  def cmp_layout3_colone_form(composant)

      config =   ConfigCmp.chargement_fichier_configuration(@skin_public, "art_layout3_colone.yml")

     render :partial=>"/composants_atomiques/cmp_layout3_colone/cmp_layout3_colone_form" ,:locals=>{:obj=>composant,:config=>config}
  end
  def cmp_layout3_colone(composant)
     render :partial=>"/composants_atomiques/cmp_layout3_colone/cmp_layout3_colone" ,:locals=>{:obj=>composant,:articles=>composant.cmp_article.cmp_articles}
  end
end
