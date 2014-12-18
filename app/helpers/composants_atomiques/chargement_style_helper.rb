module ComposantsAtomiques::ChargementStyleHelper

def stylesheet_link_tag_cmp_article(theme,nom_fichier)
  style = ""
  if File.exist?("#{RAILS_ROOT}/public/stylesheets/themes/#{theme}/articles/#{nom_fichier}.css")
  style =  stylesheet_link_tag "themes/#{theme}/articles/#{nom_fichier}"
  else
  style = stylesheet_link_tag "themes/public_sys/articles/#{nom_fichier}"
  end
  return style
end

 

end
