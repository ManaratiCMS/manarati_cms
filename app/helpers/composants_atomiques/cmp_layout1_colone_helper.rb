module ComposantsAtomiques::CmpLayout1ColoneHelper
  def cmp_layout1_colone(composant)
    
    render :partial => "composants_atomiques/cmp_layout1_colone/cmp_layout1_colone",:locals=>{:obj=>composant,:articles=>composant.cmp_article.cmp_articles}
  end

  def cmp_layout1_colone_form(composant)
      config =   ConfigCmp.chargement_fichier_configuration(@skin_public, "cmp_layout1_colone.yml")
      render :partial=>"/composants_atomiques/cmp_layout1_colone/cmp_layout1_colone_form",:locals=>{:config=>config, :obj=>composant}
  end
end
