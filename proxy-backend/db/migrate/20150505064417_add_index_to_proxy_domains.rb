class AddIndexToProxyDomains < ActiveRecord::Migration
  def change
    add_index :proxy_domains, :proxy, unique: true
  end
end
