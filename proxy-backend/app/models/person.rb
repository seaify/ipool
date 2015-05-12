# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ActiveRecord::Base
end
