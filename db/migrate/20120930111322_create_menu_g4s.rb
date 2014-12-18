class CreateMenuG4s < ActiveRecord::Migration
  def self.up
    create_table :menu_g4s do |t|
      t.string   "reference"
      t.string   "nom"
      t.string   "description"
      t.integer  "ordre",        :default => 0, :null => false
      t.integer  "ref_id"
      t.string   "langue",                      :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :menu_g4s
  end
end
