class AddTypeContenuCmpComposant < ActiveRecord::Migration
  def self.up
    add_column :cmp_composants,:type_contenu,:string
  end

  def self.down
  end
end
