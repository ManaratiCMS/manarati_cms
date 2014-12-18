module ComposantsAtomiques::CmpLayout1Helper


   def cmp_layout1_form(composant)
     render :partial=>"/composants_atomiques/cmp_layout1/cmp_layout1_form" ,:locals=>{:obj=>composant}
  end
  def cmp_layout1(composant)
     

     render :partial=>"/composants_atomiques/cmp_layout1/cmp_layout1" ,:locals=>{:obj=>composant,:articles=>composant.cmp_article.cmp_articles}
  end
end
