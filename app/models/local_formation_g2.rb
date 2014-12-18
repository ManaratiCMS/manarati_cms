class LocalFormationG2 < ActiveRecord::Base
    belongs_to :cmp_photo,:dependent => :destroy
  def initialize(atributs=nil)
    super(atributs)
    self.cmp_photo = CmpPhoto.new
  end
end
