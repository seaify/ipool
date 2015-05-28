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
#  banned      :boolean          default(FALSE)
#  banned_time :datetime
#  in_use      :boolean          default(FALSE)
#  country     :string(255)
#

FactoryGirl.define do
  factory :proxy_domain , class: ProxyDomain do
    proxy_type "http"
    domain "zillow.com"

    trait :banned do
      banned true
    end

    trait :in_use do
      in_use true
    end

    factory :high_proxy , class: ProxyDomain do
      proxy "http://54.191.128.38:3128/"
      succ_ratio 0.9
    end

    factory :middle_proxy , class: ProxyDomain do
      proxy "http://173.82.2.234:8089/"
      succ_ratio 0.5
    end

    factory :low_proxy , class: ProxyDomain do
      proxy "http://12.201.109.22:8080/"
      succ_ratio 0.3
    end

  end

end
