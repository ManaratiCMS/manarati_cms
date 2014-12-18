module ComposantsAtomiques::CmpMessageHelper
  def cmp_message(obj)
    render :partial => "composants_atomiques/cmp_message/cmp_message", :locals => { :obj => obj }
  end

  def cmp_message_form(obj)
      render :partial=>"/composants_atomiques/cmp_message/cmp_message_form",:locals=>{:obj=>obj}
  end
end
