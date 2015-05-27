# == Schema Information
#
# Table name: proxies
#
#  id          :int(11)(4)       not null, primary key
#  proxy       :varchar(255)(255
#  banned      :tinyint(1)(1)    default(FALSE)
#  banned_time :datetime
#  proxy_type  :varchar(255)(255 default("http")
#  succ_ratio  :float(24)        default(0.0)
#  succ        :int(11)(4)       default(0)
#  total       :int(11)(4)       default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country     :varchar(255)(255
#

class Proxy < ActiveRecord::Base
end
