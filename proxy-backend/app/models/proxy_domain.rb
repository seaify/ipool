# == Schema Information
#
# Table name: proxy_domains
#
#  id          :int(11)(4)       not null, primary key
#  proxy       :varchar(255)(255
#  domain      :varchar(255)(255
#  proxy_type  :varchar(255)(255 default("http")
#  succ_ratio  :float(24)        default(0.0)
#  succ        :int(11)(4)       default(0)
#  total       :int(11)(4)       default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  banned      :varchar(255)(255
#  banned_time :datetime
#  in_use      :int(11)(4)       default(0)
#  country     :varchar(255)(255
#

class ProxyDomain < ActiveRecord::Base
end
