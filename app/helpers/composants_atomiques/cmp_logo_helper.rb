module ComposantsAtomiques::CmpLogoHelper
  def cmp_logo(obj)
    render :partial => "composants_atomiques/cmp_logo/cmp_logo", :locals => { :obj => obj }
  end

  def cmp_logo_form(obj)
      render :partial=>"/composants_atomiques/cmp_logo/cmp_logo_form",:locals=>{:obj=>obj}
  end
end
