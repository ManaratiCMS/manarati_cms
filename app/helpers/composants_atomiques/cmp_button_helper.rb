module ComposantsAtomiques::CmpButtonHelper
  def cmp_button(obj_cmp_button)
    html = ""
    html << '<div id="' + obj_cmp_button.id_button  + '" class="cmp_button"><a href="' +  obj_cmp_button.lien + '"'
    html << 'title="' + obj_cmp_button.titre + '"><span>' + obj_cmp_button.nom + '</span></a></div>'
    html
  end
end
