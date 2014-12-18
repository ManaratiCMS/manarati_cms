# To change this template, choose Tools | Templates
# and open the template in the editor.

class CmpPlan
  attr_accessor :liste_element_plan
  def initialize(request_url)
    @liste_element_plan = Array.new
#    @liste_element_page = SerialisationUtil.load("#{RAILS_ROOT}/data_yml/plan_site/plan_site.yml")
#    url_page_actuel = UrlManager.get_lien_relatif_page(request_url)
##    @code_page = PlanSite.recherche_code(@liste_element_page,url_page_actuel)
#    @array_chemin_page = PlanSite.recherche_chemin_page(@liste_element_page,url_page_actuel,nil)
#    p "array chemin_page"
#    p @array_chemin_page
#    if !@array_chemin_page.blank? && @array_chemin_page.size > 0
#      @code_page = @array_chemin_page[@array_chemin_page.size-1].code
#    end
#
#    @aray_codes_chemin_page = []
#    @array_chemin_page.each { |item|
#      @aray_codes_chemin_page.insert(@aray_codes_chemin_page.size, item.code)
#    }


  end

private
#  def self.recherche_code(sous_plan,url_page)
#     code = ""
#     sous_plan.each { |item|
#         if(item.instance_of?(Array))
#              code =   PlanSite.recherche_code(item,url_page)
#              if !code.blank?
#                break
#              end
#         else
#            if (url_page== item.lien)
#              code = item.code
#               break
#            end
#
#         end
#      }
#     code
#  end
#
#  def self.recherche_chemin_page(sous_plan,url_page,chemin_page)
#     element_page = nil
#     if chemin_page.blank?
#       chemin_page = []
#     end
#     sous_plan.each { |item|
#         if(item.instance_of?(Array))
#              chemin_page =  PlanSite.recherche_chemin_page(item,url_page,chemin_page)
#              if !chemin_page.blank? && chemin_page.size > 0
#                chemin_page.insert(0,  PlanSite.get_first_element_of_array(sous_plan[0]))
#                break
#              end
#         else
#            if (url_page== item.lien)
#              element_page = item
#              chemin_page.insert(0, element_page)
#              if (element_page.code != sous_plan[0].code)
#              chemin_page.insert(0,  PlanSite.get_first_element_of_array(sous_plan[0]))
#              end
#               break
#            end
#
#         end
#      }
#     chemin_page
#  end
#
#
#  def self.get_first_element_of_array(array_or_array_element_page)
#    if(array_or_array_element_page.instance_of?(Array))
#      get_first_element_of_array(array_or_array_element_page[0])
#    else
#      array_or_array_element_page
#    end
#  end


end
