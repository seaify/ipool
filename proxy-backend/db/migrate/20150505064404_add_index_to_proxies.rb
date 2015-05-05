class AddIndexToProxies < ActiveRecord::Migration
  def change
    add_index :proxies, :proxy, unique: true
  end
end
