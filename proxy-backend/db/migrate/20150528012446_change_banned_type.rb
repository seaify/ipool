class ChangeBannedType < ActiveRecord::Migration
  def change
    change_column :proxy_domains, :banned, :boolean
  end
end
