class Utilisateur < ActiveRecord::Base
  belongs_to :cmp_photo,:dependent => :destroy
 


  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_presence_of :login, :on => :create
  validates_uniqueness_of :email
  validates_uniqueness_of :login


  def initialize(atributs=nil)
    super(atributs)
    self.cmp_photo = CmpPhoto.new
  end

  def self.authenticate(email, password)
    user = Utilisateur.find_by_email(email)
    if user && user.password == password
      user
    else
      nil
    end
  end


  def self.authenticate_by_email(email, password)
  user = Utilisateur.find_by_email(email)
  if user && user.password == password
    user
  else
    nil
  end
end

def self.authenticate_by_username(username, password)
  user = Utilisateur.find_by_login(username)
  if !user.nil? && user.password == password
    user
  else
    nil
  end
end
end
