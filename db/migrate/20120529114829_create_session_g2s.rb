class CreateSessionG2s < ActiveRecord::Migration
  def self.up
    create_table :session_g2s do |t|
    t.date  "Dates_Debut_Inscription"
    t.date   "Date_Fin_Inscription"
    t.integer   "formation_g2_id"
    t.integer "local_formation_g2_id"
    t.timestamps
    end
  end

  def self.down
    drop_table :session_g2s
  end
end
