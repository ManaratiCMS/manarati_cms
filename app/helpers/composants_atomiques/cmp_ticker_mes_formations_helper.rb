module ComposantsAtomiques::CmpTickerMesFormationsHelper
  def cmp_ticker_mes_formations(composant)
    formations = Formation.find(:all,:conditions=>["user_id = ?",composant.cmp_article.cmp_page.user_id])
     render :partial => "composants_atomiques/cmp_ticker_formation/cmp_ticker_formation", :locals => { :obj => composant,:formations=>formations }
  end

  def cmp_ticker_mes_formations_form(composant)
      render :partial=>"/composants_atomiques/cmp_ticker_formation/cmp_ticker_formation_form",:locals=>{:composant=>composant}
  end
end
