class PrototypeController < ApplicationControllerCore

  def index
##       @message = render_to_string  :partial=>"/emailer/bonjour_sur_manarati",:locals=>{:nom_site=>"fouad",:login=>"loginfouad"}
#      # Emailer.deliver_contact("pilotedev@gmail.com", "Bienvenue chez Manarati.net !", message)
#        creation_site = `bash /srv/sites/script_manager/reload.sh `

   @message = "/aaa".chars.to_a[0]
  end

  def index1
    
  end


  def cmp_image


    
  end


  def serialisation
#    article =  CmpArticle.new
#    article.group = "grou1"
#    article.reference = "referenc 1"
#    article.ref_pocesseur = ""

#    article = CmpText2.new
#    composant= CmpText.new
#    composant.reference = "Mon Premier Image"
#    composant.texte = "mon texte"
#    composant.save
#    SerialisationUtil.save("#{RAILS_ROOT}/data_yml/article.yml", composant)

#    article = CmpArticle.new
#    article.group = "grou1"
#    article.reference = "referenc 1"
#    article.ref_pocesseur = ""
#    article.cmp_composants << CmpText.new
#    article.save
#    SerialisationUtil.save("#{RAILS_ROOT}/data_yml/article.yml", article)

    p StringManager.nom_fichier_class("AaaBaa");
    p "ok"
  end

end
