module ComposantsAtomiques::<%= file_name.split('_').collect{|s|  s.capitalize }.each {|s| s } %>Helper
  def <%=file_name%>(obj)
    render :partial => "composants_atomiques/<%=file_name%>/<%=file_name%>", :locals => { :obj => obj }
  end

  def <%=file_name%>_form(obj)
      render :partial=>"/composants_atomiques/<%=file_name%>/<%=file_name%>_form",:locals=>{:obj=>obj}
  end
end
