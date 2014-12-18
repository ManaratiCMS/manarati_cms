module Admin::MenuManagerHelper


   def menu_admin

     elements_menu = CmpMenuAdmin.find(:all,:order => "ordre", :conditions=>["role is not NULL"])
     menu = Array.new

     if current_user.roles == "super_admin"
       menu = elements_menu
     else
     elements_menu.each { |element|
       if !element.role.blank? and has_role? element.role.to_sym
           menu << element
        end
     }
     end

    render :partial => "admin/menu_admin_manager/helpers/cmp_menu", :locals => {:menu => menu }
 
  end

   
end
