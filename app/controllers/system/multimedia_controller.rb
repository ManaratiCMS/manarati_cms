# Gestion des Image : il n'est pas utulisé 
class System::MultimediaController < ApplicationControllerCore

  # l'objectif de cette action est de donner un nom à l'image au moment de l'utilisation
  # pour permettre de créer de plusieurs instance d'une image
  # mais : j'ai remarqué que cette méthode générer une probléme d'affichage de l'image dans navigateur
  # alors , je vais utilise la méthode normale en attendant les test de l'equipe RD
  def image
   reference = params[:reference]
   @image = MultimediaDataManager.load_image(reference)
   send_data  File.read(@image.image_path), :disposition=>'inline', :type => "image/#{@image.type_image}", :filename => "#{@image.nom}.#{@image.type_image}",:status=>'200 OK' 
  end

  def video
  end

  def animation
  end

  def media_upload

   # Suppresion de fichier Temporaire si il existe
   if !session["file_media_uploded_path"].nil?
     if File.exist?(session["file_media_uploded_path"])
       File.delete(session["file_media_uploded_path"])
     end
     session["file_media_uploded_path"] = nil
     session["file_media_uploded"] = nil
   end

   media = params[:image]
   name =  media.original_filename
   directory = "public/media/temp"
   reference_media = Time.now.to_s
   # create the file path
   path = File.join(directory, reference_media)
   # write the file
   File.open(path, "wb") { |f| f.write(media.read) }
   session["file_media_uploded"] = reference_media
   session["file_media_uploded_path"] = path
   render :text=> "/media/temp/" + reference_media
  end

end
