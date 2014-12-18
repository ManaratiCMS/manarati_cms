# To change this template, choose Tools | Templates
# and open the template in the editor.

class <%= file_name.split('_').collect{|s|  s.capitalize }.each {|s| s } %>
  attr_accessor :var1
  def initialize
    
  end
end
