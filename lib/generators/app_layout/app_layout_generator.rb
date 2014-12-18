class AppLayoutGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.template "layout.rhtml",   "app/views/layouts/#{file_name}.rhtml"
      m.file     "stylesheet.css", "public/stylesheets/#{file_name}.css"
    end
  end
end
