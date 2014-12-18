class System::PageController < ApplicationControllerCore


  # Affiche les page de formation, element des cours
  def page_detail
    # Récupération de la page détail, c'est une modèle générique d'une page, il est configurable dans
    # la partie root.
    @page = CmpPageDetail.find_by_reference(params[:reference_page])

    # chaque page détail affiche un objet avec un Type
    # par exemple : "type_objet"=>"ElementCourG3", "reference_page"=>"video"
    @reference_objet = params[:reference_objet]
    @type_objet = params[:type_objet]

    # Calcule du chemin de la page
    @chemin_page = []
    @page.titre = ""

    # Déclaration de l'objet, par exemple l'objet de type ElementCourG3
    eval "@objet_current = #{@type_objet}.find_by_reference('#{@reference_objet}')"

    # Caclcule du chemin de la page
    if !@page.cmp_page_detail.nil? 
      
      if !@page.cmp_page_detail.cmp_page.nil?
      @chemin_page << {:nom=>( (@page.cmp_page_detail.cmp_page.cmp_menu.nil?)? @page.cmp_page_detail.cmp_page.titre : @page.cmp_page_detail.cmp_page.cmp_menu.nom ),:lien=>@page.cmp_page_detail.cmp_page.lien}
      end
      
      eval "@objet_parent = @objet_current.#{StringManager.nom_fichier_class(@page.cmp_page_detail.type_objet)}"
      if !@objet_parent.nil?
      @chemin_page << {:nom=>@objet_parent.titre,:lien=>(@page.cmp_page_detail.lien + "/" +  @objet_parent.reference)}
      @page.titre += @objet_parent.titre
      end
    else
      if !@page.cmp_page.nil?
      @chemin_page << {:nom=>( (@page.cmp_page.cmp_menu.nil?)? @page.cmp_page.titre : @page.cmp_page.cmp_menu.nom ),:lien=>@page.cmp_page.lien}
      end
    end
    @chemin_page << {:nom=>@objet_current.titre,:lien=>(@page.lien  +  ((@objet_current.reference.chars.to_a[0] == '/')? @objet_current.reference :  ("/" +@objet_current.reference) ))}


    # Calcule de titre de la page
    @page.titre += " : " if !@page.titre.blank?
    @page.titre+= @objet_current.titre if  defined?(@objet_current.titre)
    @page.description = @objet_current.description if defined?(@objet_current.description)
    
  end

  # Page ajax 
  def pajax
    @reference_objet = params[:ref_obj]
    @type_composant = params[:tp_cmp]
    eval "@objet_cmp = #{@type_composant}.new"
    @objet_cmp.id = 0
    @cmp_article_type =  CmpArticleType.find_by_type_composant(@type_composant)
     
    @objet_cmp.texte = ""

    render :layout => false
    
  end

   
end
