# == Schema Information
#
# Table name: proxies
#
#  id          :integer          not null, primary key
#  proxy       :string(255)
#  banned      :boolean          default(FALSE)
#  banned_time :datetime
#  proxy_type  :string(255)      default("http")
#  succ_ratio  :float(24)        default(0.0)
#  succ        :integer          default(0)
#  total       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country     :string(255)
#

class Proxy < ActiveRecord::Base
end
