class User < ApplicationRecord
  after_create :welcome_send

  has_many :participations, dependent: :destroy
  has_many :events, foreign_key: 'admin_id', class_name: 'Event'

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
