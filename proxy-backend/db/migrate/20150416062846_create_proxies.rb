class CreateProxies < ActiveRecord::Migration
  def change
    create_table :proxies do |t|
      t.string :proxy
      t.boolean :banned
      t.datetime :banned_time
      t.string :proxy_type
      t.float :succ_ratio
      t.integer :succ
      t.integer :total

      t.timestamps null: false
    end
  end
end
