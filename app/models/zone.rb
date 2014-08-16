class Zone < ActiveRecord::Base
belongs_to :user
has_many :networks
end
