module ComposantsSite::MenuTopHelper


  def cmp_menu_top1
    menu_top = SerialisationUtil.load("#{RAILS_ROOT}/data_yml/composants_pages/caneva_generale/menu_top1.yml")

    render :partial=>"/composants_site/menu_top", :locals => { :menu_top => menu_top,:id_menu=>"menu_top1" }
  end

  def cmp_menu_top2
    menu_top = SerialisationUtil.load("#{RAILS_ROOT}/data_yml/composants_pages/caneva_generale/menu_top2.yml")
    render :partial=>"/composants_site/menu_top", :locals => { :menu_top => menu_top ,:id_menu=>"menu_top2"}
  end

end
