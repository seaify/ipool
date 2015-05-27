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

class ProxyDomain < ActiveRecord::Base
end
