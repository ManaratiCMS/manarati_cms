module ComposantsAtomiques::CmpLayout4Helper

  def cmp_layout4(obj)
    render :partial => "composants_atomiques/cmp_layout4/cmp_layout4", :locals => { :obj => obj ,:articles=>obj.cmp_article.cmp_articles}
  end

  def cmp_layout4_form(obj)
      config =   ConfigCmp.chargement_fichier_configuration(@skin_public, "cmp_layout4.yml")
      render :partial=>"/composants_atomiques/cmp_layout4/cmp_layout4_form",:locals=>{:obj=>obj,:config=>config}
  end



   



end
