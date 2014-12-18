class AddColoneCmpComposants < ActiveRecord::Migration
  def self.up
     add_column :cmp_composants,:element_cour_g3_id ,:integer
     add_column :cmp_composants,:fichier_css,:string
     add_column :cmp_composants,:fichier_js,:string
     add_column :cmp_composants,:ordre,:integer,:default => 0
     add_column :cmp_composants,:libs_css,:string
     add_column :cmp_composants,:libs_js,:string
     add_column :cmp_composants,:ref_id,:integer
     add_column :cmp_composants,:langue,:string
     add_column :cmp_composants,:nom_zone,:string
  

  end

  def self.down
  end
end
