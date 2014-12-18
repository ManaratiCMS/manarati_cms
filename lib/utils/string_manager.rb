# To change this template, choose Tools | Templates
# and open the template in the editor.

class StringManager
  def initialize
    
  end

  # Convertir le un Nom de Type AaaBbbb to aaa_bbb
  def self.nom_fichier_class(nom_class)
    nom_var = nom_class[0,1].downcase
    nom_class[1,nom_class.length-1].each_char { |str|
      if str == str.upcase and str >= 'A' and str <= 'Z'
        nom_var +=  '_' + str.downcase
      else
        nom_var +=   str.downcase
      end
    }
    nom_var
  end


  def self.string_to_reference(chaine)
    nom_var = ""
    chaine[0,chaine.length].each_char { |str|

      if  (str >= 'a' and str <= 'z') or (str >= '0' and str <= '9')
        nom_var +=  str
      else

         case str
         when 'é'
           nom_var +=  "e"
         when 'è'
           nom_var +=  "e"
         when 'ê'
           nom_var += "e"
         when 'à'
           nom_var +=  "a"
         when 'ç'
           nom_var +=  "c"
         when 'é'
           nom_var +=  "e"
         when 'é'
           nom_var +=  "e"
         when 'é'
           nom_var +=  "e"


         else
           nom_var +=  ""
         end
      end

    }
    nom_var
  end

end
