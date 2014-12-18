class Formation < ActiveRecord::Base
  has_many :cmp_pages ,:dependent => :destroy
  belongs_to :cmp_photo,:dependent => :destroy

  belongs_to :user

  include ActionView::Helpers::TextHelper
  def initialize(atributs=nil)
    super(atributs)
    self.cmp_photo = CmpPhoto.new
    
  end

  

  def pages
     CmpPage.find(:all,:order=>"id",:conditions=>["formation_id='#{self.id}'"])
  end

  # Régle Métier de Update Formateur
  def update_formateur(id_user)
    # Mise à jour de user_id de chaque page de formation
    if(self.user_id.to_i != id_user.to_i)
      CmpPage.update_all( "user_id = " + id_user.to_s,["formation_id = ?",self.id])
    
    end

  end

  def professeur
    unless self.user.nil?
      user.nom + " " +  user.prenom
    else
      ""
    end
  end

  def plan_formation(id_page_current = 0,truncate_value=37)
    
    html = ""
    html << "<ul>"
    self.pages.each { |page|
      page.cmp_articles.each { |article|
        article.cmp_composants.each { |composant|
          if composant.type == "CmpTitre"
            if id_page_current!= 0  and id_page_current == page.id
            html << "<li><a title='#{composant.texte}' class='page_formation_active'  href='#{page.lien}##{composant.id}'>#{truncate(composant.texte,truncate_value)}</a></li>"
            else
              
              html << "<li><a  title='#{composant.texte}' href='#{page.lien}##{composant.id}'>#{ truncate(composant.texte,truncate_value)}</a></li>"
            
            end
          end
        }
      }
    }
  html << "</ul>"

  end



end
