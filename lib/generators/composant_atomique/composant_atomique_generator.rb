class ComposantAtomiqueGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
#      file_name =  "cmp_" +  file_name

#     m.directory "app/helpers/composants_atomiques"
      m.directory "app/views/composants_atomiques/#{file_name}"
#      m.directory "public/javascripts/composants/#{file_name}"
#      m.directory "public/stylesheets/themes/public_sys/articles/#{file_name}/"
#      m.directory "lib/composant_value_objet"

      m.template "composant_helper.rb",   "app/helpers/composants_atomiques/#{file_name}_helper.rb"
      m.template "composant.html.erb",   "app/views/composants_atomiques/#{file_name}/_#{file_name}.html.erb"
      m.template "composant_form.html.erb",   "app/views/composants_atomiques/#{file_name}/_#{file_name}_form.html.erb"
      m.template "composant.css",   "public/stylesheets/themes/public_sys/articles/#{file_name}.css"
      m.template "composant.rb",   "lib/composants_atomique/#{file_name}.rb"



#      m.file     "stylesheet.css", "public/stylesheets/#{file_name}.css"
    end
  end
end
