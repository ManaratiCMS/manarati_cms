# To change this template, choose Tools | Templates
# and open the template in the editor.

class CmpFormAddSite < CmpComposant
# attr_accessor :reference,:texte
 def initialize(atributs=nil)
   super(atributs)
   if !atributs.nil?
    @reference = atributs[:reference] if !atributs[:reference].nil?
    @texte = atributs[:texte] if !atributs[:texte].nil?
   end
  end
end
