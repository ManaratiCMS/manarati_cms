# Uplaod Image dans WYSIWYG
class System::ImageController < ApplicationControllerCore

  #  require ea>,>16<'RMagick'
  require 'fileutils'
  
  # Upload Image pour un composant
  def upload_wysiswyg
      width = params[:width]
      height = params[:height]
      photo = params[:photo]
      titre = params[:titre]

      # Calcule de Référence de l'image
      #[m] il faut trouver une autre moyen pour la génération de Référence UUID px
      reference_image = Time.now.to_i


      directory = "public/media/images/tmp_image/#{reference_image}/"
      name =  photo.original_filename
      directory_origine = directory + "origine_" + name
      directory_capture =directory +"/capture_" + name
      directory_image = directory  + name

      # Création de répertoire
      if !File.directory?(directory)
        Dir.mkdir(directory, 0777)
      end

      # Enregistrement
      # Origine
      File.open(directory_origine, "wb") { |f| f.write(photo.read)}
      # Eegimentionement de Capture
      img =  Magick::Image.read(directory_origine).first
      thumb = img.resize(100, 75)
      thumb.write(directory_capture )

      # Enregistrement de l'image utilisable
      if width.blank? and height.blank?
        @img_tag = "<img title='#{titre}' src='#{ "/media/images/tmp_image/" + reference_image.to_s+ "/origine_" + name}' />"
      else
        img_art = img.resize(width.to_i, height.to_i)
        img_art.write(directory_image )
        @img_tag = "<img title='#{titre}' src='#{ "/media/images/tmp_image/" + reference_image.to_s+ "/" + name}' />"
      end
  end

end
