# Upload les formulaire mathémarique de WYSIWYG TinyCme

class System::CaptureMatheController < ApplicationControllerCore

  require "base64"
  def imagecapture
   if !params[:save].nil?
     type = params[:type]

     if !params[:name].nil? and (type == "JPG" or type == "PNG")
       img =  Base64.decode64(params[:image])
       directory = "public/media/images/tmp_math/"
       if !File.directory?(directory)
        Dir.mkdir(directory, 0777)
       end
       myFile = directory +  params[:name] + "." + type
       

       File.open(myFile, "wb") { |f| f.write(img)}
       render :text=> "/media/images/tmp_math/" + params[:name] + "." + type
     end
   else
   send_data  Base64.decode64(params[:image]), :disposition=>'inline', :type => "image/jpg", :filename => "aaaa",:status=>'200 OK'
   end
  end

  


end
