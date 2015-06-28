class RenameInUseInProxy < ActiveRecord::Migration
  def change
    change_column :proxy_domains, :in_use, :integer, :default => 0
  end
end
