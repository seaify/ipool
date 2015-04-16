class CreateProxyDomains < ActiveRecord::Migration
  def change
    create_table :proxy_domains do |t|
      t.string :proxy
      t.string :domain
      t.string :proxy_type
      t.float :succ_ratio
      t.integer :succ
      t.integer :total

      t.timestamps null: false
    end
  end
end
