module ComposantsAtomiques::CmpFichetteHelperHelper
   def cmp_fichette(obj_fichette)
     render :partial=>"/composants_atomiques/cmp_fichette/fichette",:locals=>{:obj_fichette=>obj_fichette}
  end
end
