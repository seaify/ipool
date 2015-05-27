# == Schema Information
#
# Table name: proxy_domains
#
#  id          :integer          not null, primary key
#  proxy       :string(255)
#  domain      :string(255)
#  proxy_type  :string(255)      default("http")
#  succ_ratio  :float(24)        default(0.0)
#  succ        :integer          default(0)
#  total       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  banned      :string(255)
#  banned_time :datetime
#  in_use      :integer          default(0)
#  country     :string(255)
#



FactoryGirl.define do
  factory :high_proxy , class: ProxyDomain do
    proxy "http://54.191.128.38:3128/"
    proxy_type "http"
    succ_ratio 0.9
    domain "zillow.com"
  end

  factory :middle_proxy , class: ProxyDomain do
    proxy "http://173.82.2.234:8089/"
    proxy_type "http"
    succ_ratio 0.5
    domain "zillow.com"
  end

  factory :low_proxy , class: ProxyDomain do
    proxy "http://12.201.109.22:8080/"
    proxy_type "http"
    succ_ratio 0.3
    domain "zillow.com"
  end


end
