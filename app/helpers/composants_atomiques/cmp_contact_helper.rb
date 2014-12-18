module ComposantsAtomiques::CmpContactHelper

   def cmp_contact(composant)
     membre = Membre.new
     render :partial => "composants_atomiques/cmp_contact/cmp_contact", :locals => { :obj => composant ,:membre=>membre}
  end

  def cmp_contact_form(composant)
      render :partial=>"/composants_atomiques/cmp_contact/cmp_contact_form",:locals=>{:composant=>composant}
  end
  
end
