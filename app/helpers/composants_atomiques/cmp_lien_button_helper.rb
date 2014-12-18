module ComposantsAtomiques::CmpLienButtonHelper
  def cmp_lien_button_form(obj_cmp_lien_button)
     render :partial=>"/composants_atomiques/cmp_lien_button/cmp_lien_button_form" ,:locals=>{:obj=>obj_cmp_lien_button}
  end
  def cmp_lien_button(composant)
     render :partial=>"/composants_atomiques/cmp_lien_button/cmp_lien_button" ,:locals=>{:obj=>composant}
  end
end
