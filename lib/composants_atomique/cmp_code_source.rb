# To change this template, choose Tools | Templates
# and open the template in the editor.

class CmpCodeSource < CmpText
  attr_accessor :label_form
  attr_accessor :type_composant


  def initialize(atributs=nil)
    @type_composant = "cmp_code_source"
    super(atributs)
    if !atributs.nil?
    @label_form = atributs[:label_form] if !atributs[:label_form].nil?
    end
  end


end
