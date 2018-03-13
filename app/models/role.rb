class Role < ApplicationRecord
	validates_presence_of :name
	validates_uniqueness_of :name
	has_many :permissions
	has_many :users, through: :permissions
end
