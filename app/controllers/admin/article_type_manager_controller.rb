class Admin::ArticleTypeManagerController < ApplicationControllerCoreAdmin
 # Gestion des composants atomique , il s'appel aussi Article type manager
 layout "admin"
 def index
    @page.titre =  t("GestionArticlesType.Pages.Index.titre")
    @cmp_article_types = CmpArticleType.find(:all,:order=>"created_at DESC")
 end


 def new
     @cmp_article_type =CmpArticleType.new
     @type_composant_dispo = CmpComposantsExistant.find(:all)
     @packs = CmpPack.find(:all)
     @themes = CmpTheme.find(:all)
 end


  # Création d'un Composants atomique 
  def create
    cmp_article_type =CmpArticleType.new(params[:cmp_article_type])
    cmp_article_type.sys_cmp_photo = SysCmpPhoto.new(params[:sys_cmp_photo])
    if cmp_article_type.save


    # Création physique du composant
    if cmp_article_type.generation_physique == 1
    system  "ruby script/generate composant_atomique " + cmp_article_type.reference
    end

    # l'ajout des themes supporté
    liste_des_themes_client = Array.new
    liste_des_themes_client = params[:themes] if  params[:themes]
    liste_des_themes_client.each{ |ref_theme|
        theme = CmpArticleTypeTheme.new
        theme.cmp_article_type_id = cmp_article_type.id
        theme.ref_theme = ref_theme
        theme.save
    }



      flash[:notice] = t("GestionArticlesType.msg.ajouter_avec_succes")
      redirect_to :action=>:index
    else
      flash[:notice] = t("GestionArticlesType.msg.erreur_ajouter")
      render :action => :new
    end
  end


  def edit
    @type_composant_dispo = CmpComposantsExistant.find(:all)
    @cmp_article_type =CmpArticleType.find(params[:id])
    @cmp_article_type.sys_cmp_photo = SysCmpPhoto.new  if @cmp_article_type.sys_cmp_photo.nil?
    @packs = CmpPack.find(:all)
    @themes = CmpTheme.find(:all)
  end

  def update
    @cmp_article_type =CmpArticleType.find(params[:id])
    # Update Photo
    if @cmp_article_type.sys_cmp_photo.nil?
    @cmp_article_type.sys_cmp_photo = SysCmpPhoto.new
    @cmp_article_type.save
    end
    @cmp_article_type.sys_cmp_photo.update_attributes(params[:sys_cmp_photo])
    # Update themes supporté
    liste_des_themes_db = Array.new
    liste_des_themes_db = @cmp_article_type.cmp_article_type_themes.collect { |item| item.ref_theme  } if @cmp_article_type.cmp_article_type_themes
    liste_des_themes_client = Array.new
    liste_des_themes_client = params[:themes] if  params[:themes]
    # Suppresion des rôles
    liste_des_themes_db.each { |ref_theme|
      unless(liste_des_themes_client.include?(ref_theme))
        # suppresion de rôle
        theme = CmpArticleTypeTheme.find(:first,:conditions=>"ref_theme = '#{ref_theme}' and cmp_article_type_id = #{@cmp_article_type.id}")
        theme.delete
      end
    }
    # Ajoute des rôles
    liste_des_themes_client.each{ |ref_theme|
      unless(liste_des_themes_db.include?(ref_theme))
        theme = CmpArticleTypeTheme.new
        theme.cmp_article_type_id = @cmp_article_type.id
        theme.ref_theme = ref_theme
        theme.save
      end
    }


    if @cmp_article_type.update_attributes(params[:cmp_article_type])
      flash[:notice] = t("GestionArticlesType.msg.editer_avec_succes")
      redirect_to :action=>:index
    else
      render :action => :edit
    end
  end


  def delete
      cmp_article_type =CmpArticleType.find(params[:id])
      if cmp_article_type.destroy
        flash[:notice] = t("GestionArticlesType.msg.supprimer_avec_succes")
      else
        flash[:notice] = t("GestionArticlesType.msg.erreur de suppression")
      end
      redirect_to :action=>:index

  end
end
