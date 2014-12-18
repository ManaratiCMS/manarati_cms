module ComposantsAtomiques::CmpFormulaireLoginHelper
  def cmp_formulaire_login(obj)
    @user = Utilisateur.new
    render :partial => "composants_atomiques/cmp_formulaire_login/cmp_formulaire_login", :locals => { :obj => obj }
  end

  def cmp_formulaire_login_form(obj)
      render :partial=>"/composants_atomiques/cmp_formulaire_login/cmp_formulaire_login_form",:locals=>{:obj=>obj}
  end
end
