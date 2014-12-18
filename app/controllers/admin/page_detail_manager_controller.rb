class Admin::PageDetailManagerController < ApplicationControllerCoreAdmin

  layout "admin"
 
  def index
    @page = CmpPageDetail.new(:titre=>t("GestionPages.titre_de_gestion"))
    @langues_disponibles = CmpLangue.langues_actives
    if current_user.roles != "super_admin"
      @pages = CmpPageDetail.find(:all,:order=>"ordre",:conditions=>["langue = ?",@langue_active])
    else
      @pages = CmpPageDetail.find(:all,:order=>"ordre")
    end
  end


  #Ajouter une nouvelle page ou Initialisation de la page Accueil
  def new
     @page = CmpPageDetail.new(:titre=>t("GestionPages.Ajouter.titre"))
     @cmp_page = CmpPageDetail.new
     @liste_layout = CmpArticleType.find(:all,:joins => :cmp_article_type_themes,:conditions=>["cmp_article_type_themes.ref_theme = ? and is_layout = 1",@skin_public])


     @cmp_pages = CmpPage.find(:all,:order=>"ordre")
     @cmp_pages_detail = CmpPageDetail.find(:all,:order=>"ordre")
     

  end

  # Création de la page 
  def create
        page = CmpPageDetail.new(params[:cmp_page])
        #Chaque page est créé par un utilisateur
        page.user_id = current_user.id
        page.langue = @langue_active
        page.reference = StringManager.string_to_reference(page.lien)

        # Ajouter un "/" au début de lien s'il n'existe pas
        page.lien = "/" + page.lien if page.lien.chars.to_a[0] != "/"

        if page.save
          # Ajoute de Composant Layout
          ref_article = params[:layout_page]
          CmpArticle.add_article_to_page_detail(ref_article, page.id)
          flash[:notice] = t("GestionPages.msg.page_ajouter_avec_succes")
          redirect_to "/admin/article_manager/update/" + page.get_cmp_layout.id.to_s
        else
          flash[:notice] = t("GestionPages.msg.erreur_ajouter_page")
          new
          render :action => :new
        end

  end

  # Edition de la page
  def edit
    @page = CmpPageDetail.new(:titre=>t("GestionPages.Editer.titre"))
    @liste_layout = nil # Pas de modification de layout
    @cmp_page = CmpPageDetail.find(params[:id])
    @langues_active = CmpLangue.liste_objt_langues_actives
 @cmp_pages = CmpPage.find(:all,:order=>"ordre")
     @cmp_pages_detail = CmpPageDetail.find(:all,:order=>"ordre")

  end


  # Traduction de la page
  def traduir
#    @ref_langue = params[:lg]
#    @cmp_page_p = CmpPageDetail.find(params[:id])
#    @langue = CmpLangue.find_by_reference(@ref_langue)
#    @langues_active = CmpLangue.liste_objt_langues_actives
#    @traduction = true
#    if !@langue.nil?
#
#          @cmp_page = CmpPageDetail.find(:first,:conditions=>["ref_id = ? and langue = ?",params[:id],@ref_langue])
#
#
#          # Creation de la @cmp_page si il nexiste pas
#          if @cmp_page.nil?
#            @cmp_page = CmpPageDetail.new
#            @cmp_page.lien = "/" + @ref_langue  +((@cmp_page_p.lien=="/")?"":@cmp_page_p.lien)
#            @cmp_page.titre = ""
#            @cmp_page.description = ""
#            @cmp_page.mots_cle = ""
#            @cmp_page.reference = @ref_langue  +"-" + @cmp_page_p.reference
#            @cmp_page.user_id = current_user.id
#            @cmp_page.langue = @ref_langue
#            @cmp_page.ref_id =  @cmp_page_p.id
#            if @cmp_page.save
#              flash[:notice] = t("GestionPages.msg.page_ajouter_avec_succes")
#              #Layout : c'est la premier article de la page
#              article_page = CmpArticle.find(:first,:conditions=>["cmp_page_id = #{@cmp_page_p.id}"])
#              CmpArticle.add_article_to_page(article_page.ref_article_classe, @cmp_page.id,article_page.id,@ref_langue)
#            else
#              flash[:notice] = t("GestionPages.msg.erreur_ajouter_page")
#            end
#          end
#          edit_seo = params[:edit_seo]
#          if edit_seo.nil?
#          redirect_to "/admin/article_manager/update/#{@cmp_page_p.get_cmp_layout.id}?ref_langue=#{@ref_langue}"
#          else
#          redirect_to "/admin/pages_manager/edit/#{@cmp_page_p.get_page_traduit(@ref_langue).id}"
#          end
#    else
#      raise "Langue n'existe pas"
#    end
  end

  # Mise à jour d'une page
  def update
    @page = CmpPageDetail.find(params[:id])

    # Interdiction de Modification de propriétaire de page.
    if current_user.roles != "super_admin"
      if params[:cmp_page][:user_id] != @page.user_id
        params[:cmp_page][:user_id] = @page.user_id
      end
    end

    if @page.update_attributes(params[:cmp_page])
      flash[:notice] = t("GestionPages.msg.page_editer_avec_succes")
      redirect_to "/admin/page_detail_manager"
    else
      render :action => :edit
    end
  end

  # Supprimer la page et ses pages traduit
  def delete

      page = CmpPageDetail.find(params[:id])
      # Interdiction de supprimer la page principale
      if page.lien=="/"
        redirect_to "/admin/pages_manager/new/#{page.id}"
      else
        if page.lien!="/"  &&  CmpPageDetail.destroy(page.id)
          flash[:notice] = t("GestionPages.msg.page_supprimer_avec_succes")
        else
          flash[:notice] = t("GestionPages.msg.erreur de suppression")
        end
        redirect_to "/admin/page_detail_manager"
      end

  end

   def move_up
    page = CmpPageDetail.find(params[:id])
    page.move_up
    redirect_to :action=>:index
  end

  def move_down
    page = CmpPageDetail.find(params[:id])
    page.move_down
    redirect_to :action=>:index
  end

  def init_ordre
      pages = CmpPageDetail.find(:all,:conditions=>["langue = ?",@langue_active])
      pages.each_with_index { |obj,i|
        obj.ordre = i + 1
        obj.save
        pages_tr =  obj.get_pages_langue
        pages_tr.each { |p|
          p.ordre = i+1
          p.save
        }
      }
      redirect_to :action=>:index
  end
end
