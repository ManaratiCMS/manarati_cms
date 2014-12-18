module ComposantsAtomiques::CmpDerniersFormationsHelper
  def cmp_derniers_formations(obj)
    # menu_g4_id == Catégogie
    if obj.texte.nil? or obj.texte.blank?

      if has_role?(:gestion_formations_g2)
      formations = FormationG2.find(:all,:limit => 4,:order => "ordre")
      else
      formations = FormationG2.find(:all,:limit => 4,:order => "ordre",:conditions=>["protection = 1"])
      end


    else
      if has_role?(:gestion_formations_g2)
             formations = FormationG2.find(:all,:order => "ordre",:conditions=>["menu_g4_id = ?",obj.texte])
   
      else
         formations = FormationG2.find(:all,:order => "ordre",:conditions=>["protection = 1 and menu_g4_id = ?",obj.texte])

       end


    end
    render :partial => "composants_atomiques/cmp_derniers_formations/cmp_derniers_formations", :locals => { :obj => obj ,:formations=>formations}
  end

  def cmp_derniers_formations_form(obj)
      categories = MenuG4.find(:all)
      render :partial=>"/composants_atomiques/cmp_derniers_formations/cmp_derniers_formations_form",:locals=>{:obj=>obj,:categories=>categories}
  end
end
