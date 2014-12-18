module ComposantsAtomiques::CmpLayout3Helper

  def cmp_layout3_form(composant)
       config =   ConfigCmp.chargement_fichier_configuration(@skin_public, "art_cmp_layout3.yml")

     render :partial=>"/composants_atomiques/cmp_layout3/cmp_layout3_form" ,:locals=>{:obj=>composant,:config=>config}
  end
  def cmp_layout3(composant)
     

     render :partial=>"/composants_atomiques/cmp_layout3/cmp_layout3" ,:locals=>{:obj=>composant,:articles=>composant.cmp_article.cmp_articles}
  end
end
