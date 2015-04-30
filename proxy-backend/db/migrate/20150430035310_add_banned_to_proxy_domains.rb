class AddBannedToProxyDomains < ActiveRecord::Migration
  def change
    add_column :proxy_domains, :banned, :string
    add_column :proxy_domains, :banned_time, :datetime
  end
end
