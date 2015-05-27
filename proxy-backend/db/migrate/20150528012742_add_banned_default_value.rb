class AddBannedDefaultValue < ActiveRecord::Migration
  def change
    change_column_default :proxy_domains, :banned, false
  end
end
