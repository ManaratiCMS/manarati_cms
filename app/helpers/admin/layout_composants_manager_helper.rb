module Admin::LayoutComposantsManagerHelper
  def layout_composants_zone_manager(id_parent,nom_zone,width = 0,height = 0)
     layout_composants_zone_manager_abstract(false,nil,id_parent,nom_zone,width,height)
  end
  def layout_composants_zone_manager_tr(traduction,ref_langue,id_parent,nom_zone,width = 0,height = 0)
     layout_composants_zone_manager_abstract(traduction,ref_langue,id_parent,nom_zone,width,height)
  end

  def layout_composants_zone_manager_abstract(traduction,ref_langue,id_parent,nom_zone,width = 0,height = 0)
    articles = CmpArticle.find(:all,:order=>"ordre",:conditions=>["cmp_article_id = #{id_parent} and nom_zone='#{nom_zone}'"])
    articles = [] if articles.nil?
    render :partial=>"admin/layout_composants_manager/partials/index" ,:locals=>{:traduction=> traduction ,:ref_langue => ref_langue ,:articles=>articles,:nom_zone=>nom_zone,:id_parent=>id_parent,:width=>width,:height=> height}
  end


  
end
