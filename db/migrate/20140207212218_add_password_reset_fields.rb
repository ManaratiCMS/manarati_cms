class AddPasswordResetFields < ActiveRecord::Migration
  def self.up
    add_column :utilisateurs, :password_reset_token, :string
    add_column :utilisateurs, :password_expires_after, :datetime
  end

  def self.down
    remove_column :utilisateurs, :password_reset_token
    remove_column :utilisateurs, :password_expires_after
  end
end
