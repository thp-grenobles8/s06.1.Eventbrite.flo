class Participation < ApplicationRecord
  after_create :new_participation_send

  belongs_to :user
  belongs_to :event

  def new_participation_send
    UserMailer.new_participation_email(self).deliver_now
  end
end
