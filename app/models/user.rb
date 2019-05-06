class User < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :events, foreign_key: 'admin_id', class_name: 'Event'
end
