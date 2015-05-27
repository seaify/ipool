# == Schema Information
#
# Table name: entries
#
#  id         :int(11)(4)       not null, primary key
#  name       :varchar(255)(255
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Entry < ActiveRecord::Base
	#attr_accessible :name
end
