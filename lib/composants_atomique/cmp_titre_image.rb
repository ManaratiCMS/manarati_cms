# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'rubygems' # pour le fonctionement de Rmagick
require 'RMagick'
require 'fileutils'

class CmpTitreImage < CmpPhoto
  def initialize(atributs=nil)
    super(atributs)
  end
end
