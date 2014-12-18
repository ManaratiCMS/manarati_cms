# To change this template, choose Tools | Templates
# and open the template in the editor.

class CmpComposantAtomiqueManager
  def initialize
    
  end

  def self.getCmpParType(type,atributs=nil)
    eval(type + ".new(atributs)")
  end
end
