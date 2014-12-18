module ComposantsAtomiques::CmpYoutubeHelper
  def cmp_youtube(obj)
    render :partial => "composants_atomiques/cmp_youtube/cmp_youtube", :locals => { :obj => obj }
  end

  def cmp_youtube_form(obj)

      render :partial=>"/composants_atomiques/cmp_youtube/cmp_youtube_form",:locals=>{:obj=>obj}
  end
end
