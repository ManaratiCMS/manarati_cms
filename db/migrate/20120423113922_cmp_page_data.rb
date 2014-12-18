class CmpPageData < ActiveRecord::Migration
  def self.up
      # Ajouter la page Principale
      page = CmpPage.new
      page.lien = "/"
      page.titre = "Page Principale"
      page.reference ="page1"
      page.description = ""
      page.mots_cle = ""
      page.langue = "fr"
   if  ! page.save
     raise "la page principlae n'est pas crée"
   end

      # Ajouter layout Principale dans la page page principale
      CmpArticle.add_article_to_page("layout2c", page.id)
  end

  def self.down
  end
end
