
require 'rubygems' # pour le fonctionement de Rmagick
require 'RMagick'
require 'fileutils'

class CmpPhoto < CmpComposant

  attr_accessor :label_form
  attr_accessor :texte_alt
  attr_accessor :type_composant
  attr_accessor :photo # Contient le contenu de photo
  attr_accessor :width_capture
  attr_accessor :height_capture

  # Enregistrement physique de l'image après l'enregistremnt de composant
  after_save { |record|
    record.save_photo
  }

  # Supprimer le fichier physique
  before_destroy { |record|
    FileUtils.rm_rf 'public/media/images/' + record.id.to_s  +  '/'
  }


  def initialize(atributs=nil)
    @type_composant = "photo"
    if !atributs.nil?
      @label_form = atributs[:label_form] if !atributs[:label_form].nil?
      @texte_alt = atributs[:texte_alt] if !atributs[:texte_alt].nil?
      @photo = atributs[:photo]
      if !@photo.nil?
        # Suppression de l'atribut photo : il n'existe pas dans la table
        atributs.delete('photo')
        atributs["texte"] = @photo.original_filename
      end
    else
      atributs={}
      atributs[:reference] = "cmp_photo"
    end
    super(atributs)
  end

  # Modification d'image
  def update_attributes(atributs)
    @photo = atributs[:photo]
    if !@photo.nil?
        # Suppression de l'atribut photo : il n'existe pas dans la table
        atributs.delete('photo')
        atributs["texte"] = @photo.original_filename
        self.width_capture = atributs[:width_capture]
        self.height_capture = atributs[:height_capture]
        save_photo
    else
      # Détection de mise à jour de dimension
      if (!self.width.nil? and self.width != atributs["width"]) or (!self.height.nil? and self.height != atributs["height"])
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
      directory ="public/media/images/" + numero_image.to_s  + "/"
      origine_directory = directory + "origine/"

      # Création de Répertoir s'il n'existe pas
      # s'il existe : je supprime puis je les créent à nouveau
      if !File.directory?(directory)
        Dir.mkdir(directory, 0777)
      else
        if !numero_image.nil? && numero_image!="" # Sécurité de suppresion de toutes les images
        FileUtils.remove_entry 'public/media/images/' + numero_image.to_s  +  '/' , true
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
      width_of_caputre = 100
      height_of_capture = 75
      p "ok"
      p img.rows
      p img.columns
      width_of_caputre = self.width_capture unless  self.width_capture.nil?
      height_of_capture = self.height_capture unless self.height_capture.nil?
      
      thumb = img.resize(width_of_caputre, height_of_capture)
      thumb.write(directory + "thumbnail_" +name )

      # Calcule de Widht et heigth s'il ne sont pas déclarer
      if ( self.width.nil? or  self.width == 0)
      self.width = img.columns
      self.height = img.rows
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
    directory ="public/media/images/" + numero_image.to_s  + "/"
    origine_directory = directory + "origine/"
    path_origine = File.join(origine_directory, name)
    img =  Magick::Image.read(path_origine).first
   
    # Tails de l'image
    if ( self.width.nil? or  self.width == 0)
      self.width = img.columns
      self.height = img.rows
      else
         if self.height.nil? or self.height == 0
          pourcentage_width = self.width.to_f / img.columns.to_f
          p img.rows
          p self.width
          p img.columns
          p pourcentage_width
          self.height = img.rows* pourcentage_width
          p self.height
         end
      end

    img_art = img.resize(self.width, self.height)

    img_art.write(directory +name )
  end

  private
  def reglage_width_hieght
      if ( self.width.nil? or  self.width == 0)
      self.width = img.columns
      self.height = img.rows
      else
         if self.height.nil? or self.height == 0
          self.height = self.width * 0.75
         end
      end
  end
  

end
