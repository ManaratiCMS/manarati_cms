# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'rubygems' # pour le fonctionement de Rmagick
require 'RMagick'
require 'fileutils'

class SysCmpPhoto < SysCmpComposant

  attr_accessor :photo # Contient le contenu de photo
   
  # Enregistrement physique de l'image après l'enregistremnt de composant
  after_save { |record|
    record.save_photo
  }
  before_destroy { |record|
    FileUtils.rm_rf 'public/media/images_system/' + record.id.to_s  +  '/'
  }


  def initialize(atributs=nil)
    if !atributs.nil?
      @texte_alt = atributs[:texte_alt] if !atributs[:texte_alt].nil?
      @photo = atributs[:photo]
      if !@photo.nil?
        # Suppression de l'atribut photo : il n'existe pas dans la table
        atributs.delete('photo')
        atributs["texte"] = @photo.original_filename
      end
    else
      atributs={}
      atributs[:reference] = "sys_cmp_photo"
    end
    super(atributs)
  end

  def update_attributes(atributs)
    @photo = atributs[:photo]
    if !@photo.nil?
        # Suppression de l'atribut photo : il n'existe pas dans la table
        atributs.delete('photo')
        atributs["texte"] = @photo.original_filename
        save_photo
    else
      # Détection de mise à jour de dimension
      if (self.width != atributs["width"] and !atributs["width"].blank?)  or (self.height != atributs["height"] and !atributs["height"].blank?  )
        self.width = atributs["width"]
        self.height = atributs["height"]
        update_size
      end
    end
    
    self.attributes = atributs
    save(false)
  end

  # Redimentionement et Enregistrement  physique de la photo
  def save_photo
     if !@photo.nil?

      # Nom et Répertoir
      name =  @photo.original_filename
      numero_image = self.id
      directory ="public/media/images_system/" + numero_image.to_s  + "/"
      origine_directory = directory + "origine/"

      # Création de Répertoir s'il n'existe pas
      # s'il existe : je supprime puis je les créent à nouveau
      if !File.directory?(directory)
        Dir.mkdir(directory, 0777)
      else
        if !numero_image.nil? && numero_image!="" # Sécurité de suppresion de toutes les images
        FileUtils.remove_entry 'public/media/images_system/' + numero_image.to_s  +  '/' , true
        end
        Dir.mkdir(directory, 0777)
      end
      if !File.directory?(origine_directory)
      Dir.mkdir(origine_directory, 0777)
      end
      
      # Enregistrement de fichier originale
      path_origine = File.join(origine_directory, name)
      File.open(path_origine, "wb") { |f| f.write(@photo.read)}
      @photo=nil

      # Eegimentionement de Capture
      img =  Magick::Image.read(path_origine).first
      thumb = img.resize(100, 75)
      thumb.write(directory + "thumbnail_" +name )

      # Calcule de Widht et heigth s'il ne sont pas déclarer
      if ( self.width.nil? or  self.width == 0)
      self.width = 650 if self.width.nil?
      self.height = 650 * 0.75 if self.height.nil?
      else
         if self.height.nil? or self.height == 0
          self.height = self.width * 0.75
         end
      end
      
      # Enregistrement de l'image utilisable
      img_art = img.resize(self.width, self.height)
      img_art.write(directory +name )

      

    end
  end

  # Redimentionement
  def update_size
    # Nom et Répertoir
    name =   self.texte
    numero_image = self.id
    directory ="public/media/images_system/" + numero_image.to_s  + "/"
    origine_directory = directory + "origine/"
    path_origine = File.join(origine_directory, name)
    img =  Magick::Image.read(path_origine).first
    img_art = img.resize(self.width, self.height)
    img_art.write(directory +name )
  end
  

end
