# == Schema Information
#
# Table name: people
#
#  id         :int(11)(4)       not null, primary key
#  name       :varchar(255)(255
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ActiveRecord::Base
end
