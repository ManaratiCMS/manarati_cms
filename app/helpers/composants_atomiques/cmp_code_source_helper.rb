module ComposantsAtomiques::CmpCodeSourceHelper
  def cmp_code_source(obj_cmp_code_source)
         render :partial => "composants_atomiques/cmp_code_source/cmp_code_source", :locals => { :obj => obj_cmp_code_source }
  end

    def cmp_code_source_form(obj_cmp_code_source)
      # Type de Langage Disponible
      langages_source = YAML::load(File.open("#{RAILS_ROOT}/app/views/composants_atomiques/cmp_code_source/LangageDisponibles.yml", "r"))
      @langages = langages_source.collect {|value,key| [  key, value]  }
      render :partial=>"/composants_atomiques/cmp_code_source/cmp_code_source_form",:locals=>{:obj=>obj_cmp_code_source}
  end
end
