module ComposantsAtomiques::CmpFormAddSiteHelper
  def cmp_form_add_site_form(obj)
     render :partial=>"/composants_atomiques/cmp_form_add_site/cmp_form_add_site_form" ,:locals=>{:obj=>obj}
  end
  def cmp_form_add_site(obj)
     render :partial=>"/composants_atomiques/cmp_form_add_site/cmp_form_add_site" ,:locals=>{:obj=>obj}
  end
end
