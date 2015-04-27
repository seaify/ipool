class ChangeColumnDefault < ActiveRecord::Migration
  def change
  	change_column_default :proxies, :succ, 0 
  	change_column_default :proxies, :total, 0 
  	change_column_default :proxies, :succ_ratio, 0.0 
  	change_column_default :proxies, :banned,  false
  	change_column_default :proxies, :proxy_type, 'http' 

  	change_column_default :proxy_domains, :succ, 0 
  	change_column_default :proxy_domains, :total, 0 
  	change_column_default :proxy_domains, :succ_ratio, 0 
  	change_column_default :proxy_domains, :proxy_type,  'http'
  end
end
