module Admin::ArticleManagerHelper

 


  # Version 2 :
  # Edition des articles d'un possecceur
  def module_edition_articles(id_page,arg={})
    @articles = CmpArticle.find(:all,:order=>"ordre",:conditions=>["cmp_page_id = #{id_page}"])
    @articles = [] if @articles.nil?
    ref_langue = arg[:ref_langue]
    traduction = arg[:traduction]
    render :partial=>"admin/article_manager/helpers/edition_articles" , :locals=>{:traduction=>traduction,:ref_langue=>ref_langue,:articles=>@articles,:id_page=>id_page}
  end


  # Afficher le DataGrid ou la liste des Article
  # Gestion des articles
  def module_gestion_articles(ref_possecceur,sender_id,sender_url,arg={})
    if ref_possecceur.blank?
     @articles = CmpArticle.find(:all)
    else
     @articles = CmpArticle.find(:all,{:conditions=>"ref_pocesseur='#{ref_possecceur}'"})
    end
    @articles = [] if @articles.nil?
    @ref_possecceur = ref_possecceur

    #Argument
    titre_button_ajouter = arg[:titre_button_ajouter] || ""
    titre_liste_article = arg[:titre_liste_article] || ""
    titre_formulaire_ajouter_article = arg[:titre_formulaire_ajouter_article] || ""

    render :partial=>"admin/article_manager/helpers/gestion_articles" , :locals=>{:sender_id=>sender_id,:sender_url=>sender_url,:titre_liste_article=>titre_liste_article,:titre_button_ajouter=>titre_button_ajouter,:titre_formulaire_ajouter_article=>titre_formulaire_ajouter_article}
  end
end
