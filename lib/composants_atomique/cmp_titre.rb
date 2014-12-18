# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'rubygems' # pour le fonctionement de Rmagick
require 'RMagick'
require 'fileutils'

class CmpTitre < CmpComposant
  # Font : image ou texte
  attr_accessor :type_composant
    attr_accessor :width_capture
  attr_accessor :height_capture

  # Création de l'image si le font de Titre n'est pas pardéfaut
  after_save { |record|
    record.create_image
  }
  before_destroy { |record|
    FileUtils.rm_rf 'public/media/images/' + record.id.to_s  +  '/'
  }


  def initialize(atributs=nil)
    config = CmpTitre.get_config
    @type_composant = "CmpTitre"
    atributs[:font] =config["type"] if !atributs.nil?
    super(atributs)
    if !atributs.nil?
    end
  end

  def self.get_config
      ConfigCmp.chargement_fichier_configuration(CmpTheme.theme_active.ref_theme, "cmp_titre.yml")
  end

  def create_image
     # Chargement de paramestres
  
     config = CmpTitre.get_config

     if self.font == "image"
       
      # Chemin 
      numero_image = self.id
      directory ="public/media/images/" + numero_image.to_s  + "/"
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



      container= Magick::Image.new(200,50){
        self.background_color = 'transparent'
      }
      container.format = 'PNG'


      #Initialize a new image
      image=Magick::Draw.new
#      image.stroke('transparent')
      image.fill("#" + config["font_color"])
      image.font= config["font"]
      image.pointsize=config["font_size"]
#      image.font_weight=Magick::BoldWeight
      image.text(0,config["font_size"],self.texte)
      image.interword_spacing  = 5
      image.text_antialias(true)
      image.font_style=Magick::NormalStyle
      image.draw(container)

      
      metrics = image.get_multiline_type_metrics(container,self.texte)
      container= Magick::Image.new(metrics.width + 5,metrics.height){
        self.background_color = 'transparent'
      }
      container.format = 'PNG'
      image.draw(container)
 
      
      # Enregistrement de l'image utilisable
      container.write(directory + self.texte + ".png" )

    end
  end

  private
  def reglage_width_hieght
        if ( self.width.nil? or  self.width == 0)
      self.width = 650 if self.width.nil?
      self.height = 650 * 0.75 if self.height.nil?
      else
         if self.height.nil? or self.height == 0
          self.height = self.width * 0.75
         end
      end
  end
end
