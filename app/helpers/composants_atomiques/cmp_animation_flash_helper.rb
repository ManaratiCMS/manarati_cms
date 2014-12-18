module ComposantsAtomiques::CmpAnimationFlashHelper
  def cmp_animation_flash(obj)
    render :partial => "composants_atomiques/cmp_animation_flash/cmp_animation_flash", :locals => { :obj => obj }
  end

  def cmp_animation_flash_form(obj)
      render :partial=>"/composants_atomiques/cmp_animation_flash/cmp_animation_flash_form",:locals=>{:obj=>obj}
  end


    # Params : alt = true
  def cmp_animation_flash_input(composant,args={})
     render :partial=>"/composants_atomiques/cmp_animation_flash/animation_flash_input" ,:locals=>{:obj=>composant,:args=>args}
  end

  
end
