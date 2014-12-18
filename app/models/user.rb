class User < ActiveRecord::Base
#    using_access_control
has_many :user_roles
    acts_as_authentic

    has_many :formations
#    belongs_to :cmp_photo,:dependent => :destroy
#    attr_accessible :roles
  def initialize(atributs=nil)
    super(atributs)
#    self.cmp_photo = CmpPhoto.new # il a générer un probléme avec rmagic
  end

#  def save(perform_validation = true)
#
#
#
#   if super(perform_validation)
#     p "save usrr"
#
#    return true
#   else
#        p "note save user"
#     return false
#   end
#  end


 
  # Start of code needed for the declarative_authorization plugin
  #
  # Roles are stored in a serialized field of the User model.
  # For many applications a separate UserRole model might be a
  # better choice.
  

  # The necessary method for the plugin to find out about the role symbols
  # Roles returns e.g. [:admin]
  def role_symbols
    roles_array = []
    roles_array = self.user_roles.map { |r| r.nom.to_sym  }
    p roles_array
    roles_array
  end
  # End of declarative_authorization code

  end
