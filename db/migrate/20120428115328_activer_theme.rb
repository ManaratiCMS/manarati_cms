class ActiverTheme < ActiveRecord::Migration
  def self.up
    theme = CmpTheme.find_by_ref_theme("theme3")
    theme.activer()
  end

  def self.down
  end
end
