# Gestion de Media : il n'est pas utilisé
class Admin::MediaManagerController < ApplicationControllerCoreAdmin

  layout "admin"
  before_filter :config_media


  def index
    conditions = []
    @config["type_media"].each { |key,value| 
      conditions << "type = '" + key + "'"
    }
    @medias = CmpComposant.find(:all,:conditions => conditions.join(" or "))
  end

  def new
    @media = CmpComposant.new
  end

  def create
    if !params[:id].blank? and !params[:media].nil?
        CmpComposant.update(params[:id], params[:media])
        else
          media = CmpComposant.new(params[:media])
          eval(" media =#{params[:media][:type]}.new(params[:media])")
          media.save
        end
        redirect_to  :action=>:index
  end

  def update
    params[:id] = params[:sender_id] if !params[:sender_id].nil?
    @media = CmpComposant.find(params[:id])
    render :action=>:new
  end

  def delete
      media = CmpComposant.find(params[:id])
      media.delete
      redirect_to  :action=>:index
  end

  private
  def config_media
    @config  = YAML.load_file(File.join(RAILS_ROOT,"config_application/composants_atomiques/cmp_media/cmp_media.yml"))
  end

end
