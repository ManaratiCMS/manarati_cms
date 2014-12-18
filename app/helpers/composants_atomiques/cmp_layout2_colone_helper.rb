module ComposantsAtomiques::CmpLayout2ColoneHelper


  def cmp_layout2_colone_form(composant)
     config =   ConfigCmp.chargement_fichier_configuration(@skin_public, "art_layout2_colone.yml")
     render :partial=>"/composants_atomiques/cmp_layout2_colone/cmp_layout2_colone_form" ,:locals=>{:obj=>composant,:config=>config}
  end
  def cmp_layout2_colone(composant)
     

     render :partial=>"/composants_atomiques/cmp_layout2_colone/cmp_layout2_colone" ,:locals=>{:obj=>composant,:articles=>composant.cmp_article.cmp_articles}
  end
end
