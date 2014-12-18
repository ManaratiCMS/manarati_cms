#class  PageSweeper  < ActionController::Caching::Sweeper
#
#  observe CmpPage # This sweeper is going to keep an eye on the CmpPage model
#
#
#  # If our sweeper detects that a CmpPage was created call this
#  def after_create(page)
#    expire_cache_for(page)
#  end
#
#  # If our sweeper detects that a CmpPage was updated call this
#  def after_update(page)
#    expire_cache_for(page)
#  end
#
#  # If our sweeper detects that a CmpPage was deleted call this
#  def after_destroy(page)
#    expire_cache_for(page)
#  end
#
#  private
#  def expire_cache_for(page)
#    # Expire the index page now that we added a new product
#    expire_page(:controller => 'system/srticles', :action => 'afficher')
#    expire_page(:controller => 'system/srticles', :action => 'afficher_page_formation')
#
#    # Expire a fragment
#    expire_fragment('all_available_pages')
#  end
#end
