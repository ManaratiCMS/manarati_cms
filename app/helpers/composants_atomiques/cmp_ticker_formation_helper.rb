module ComposantsAtomiques::CmpTickerFormationHelper
  def cmp_ticker_formation(composant)
     formations = FormationG2.find(:all,:order=>"ordre")
     render :partial => "composants_atomiques/cmp_ticker_formation/cmp_ticker_formation", :locals => { :obj => composant,:formations=>formations }
  end

  def cmp_ticker_formation_form(composant)
      render :partial=>"/composants_atomiques/cmp_ticker_formation/cmp_ticker_formation_form",:locals=>{:composant=>composant}
  end

end
