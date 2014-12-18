# To change this template, choose Tools | Templates
# and open the template in the editor.
class CmpAnimationFlash < CmpComposant



  attr_accessor :flash # Contient le contenu de document flash

  # Enregistrement physique de l'animation après l'enregistremnt du composant
  after_save { |record|
    record.save_flash
  }
  before_destroy { |record|
    FileUtils.rm_rf 'public/media/flashs/' + record.id.to_s  +  '/'
  }


  def initialize(atributs=nil)
    if !atributs.nil?
      @flash = atributs[:flash]
      if !@flash.nil?
        # Suppression de l'atribut flash : il n'existe pas dans la table
        atributs.delete('flash')
        atributs["texte"] = @flash.original_filename
      end
    else
      atributs={}
      atributs[:reference] = "cmp_flash"
    end
    super(atributs)
  end

  def update_attributes(atributs)
    @flash = atributs[:flash]
    if !@flash.nil?
        # Suppression de l'atribut flash : il n'existe pas dans la table
        atributs.delete('flash')
        atributs["texte"] = @flash.original_filename
        save_flash
    else
      # Détection de mise à jour de dimension
      if (!self.width.nil? and self.width != atributs["width"]) or (!self.height.nil? and self.height != atributs["height"])
        self.width = atributs["width"]
        self.height = atributs["height"]
      end
    end

    self.attributes = atributs
    save(false)
  end

  # Redimentionement et Enregistrement  physique de document flash
  def save_flash
     if !@flash.nil?

      # Nom et Répertoir
      name =  @flash.original_filename
      numero_flash = self.id
      directory ="public/media/flashs/" + numero_flash.to_s  + "/"
     
      # Création de Répertoir s'il n'existe pas
      # s'il existe : je supprime puis je les créent à nouveau
      if !File.directory?(directory)
        Dir.mkdir(directory, 0777)
      else
        if !numero_flash.nil? && numero_flash!="" # Sécurité de suppresion de toutes les images
        FileUtils.remove_entry 'public/media/flashs/' + numero_flash.to_s  +  '/' , true
        end
        Dir.mkdir(directory, 0777)
      end
     
      # Enregistrement de fichier originale
      path_origine = File.join(directory, name)
      File.open(path_origine, "wb") { |f| f.write(@flash.read)}
      @flash=nil


    end
  end

  
 



end
