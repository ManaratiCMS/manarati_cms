module ComposantsAtomiques::CmpFormContactHelper
  def cmp_form_contact_form(obj)
     render :partial=>"/composants_atomiques/cmp_form_contact/cmp_form_contact_form" ,:locals=>{:obj=>obj}
  end
  def cmp_form_contact(obj)
     render :partial=>"/composants_atomiques/cmp_form_contact/cmp_form_contact" ,:locals=>{:obj=>obj}
  end
end
