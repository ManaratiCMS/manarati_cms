module ComposantsAtomiques::CmpParagrapheHelper
  def cmp_paragraphe(obj_cmp_paragraphe)
         render :partial => "composants_atomiques/cmp_paragraphe/cmp_paragraphe", :locals => { :obj => obj_cmp_paragraphe }
  end

  def cmp_paragraphe_form(obj_cmp_paragraphe)
      ref_langue = params[:ref_langue]
      if !ref_langue.nil?
      @langue = CmpLangue.find_by_reference(ref_langue)
      @langue_principal = CmpLangue.langue_principal
      end
      render :partial=>"/composants_atomiques/cmp_paragraphe/cmp_paragraphe_form",:locals=>{:ref_langue=>ref_langue,:obj_cmp_paragraphe=>obj_cmp_paragraphe}
  end

    # Params : alt = true
  def cmp_paragraphe_input(nom_objet,nom_variable,valeur)
     render :partial=>"/composants_atomiques/cmp_paragraphe/cmp_paragraphe_input" ,:locals=>{:nom_objet=>nom_objet,
       :nom_variable=>nom_variable,:valeur=>valeur}
  end
  
end
