class AddCountry < ActiveRecord::Migration
  def change
    add_column :proxy_domains, :country, :string
    add_column :proxies, :country, :string
  end
end
