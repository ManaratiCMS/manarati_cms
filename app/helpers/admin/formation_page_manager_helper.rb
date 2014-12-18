module Admin::FormationPageManagerHelper
  # Edition des pages d'une Formation
  def module_edition_pages_formation(arg={})
    id_formation =  arg[:id_formation]
    @pages = CmpPage.find(:all,:order=>"ordre",:conditions=>["formation_id='#{id_formation}'"])
    @pages = [] if @pages.nil?
    render :partial=>"admin/formation_page_manager/helpers/edition_pages" ,
      :locals=>{:id_formation=>id_formation}
  end
end
