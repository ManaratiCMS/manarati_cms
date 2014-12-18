module ComposantsSite::LogosHelper

  def logo_site(text_alternatif)
    render :partial=>"/composants_site/logo" ,:locals=>{:text_alternatif=>text_alternatif}
  end
 

end
