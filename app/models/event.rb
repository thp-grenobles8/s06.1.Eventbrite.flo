class Event < ApplicationRecord
  belongs_to :admin, class_name: 'User', dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  validates :start_date, presence: true

  validate :no_past_start_date
  def no_past_start_date
    if self.start_date < Time.now
      errors.add("La date du début de l'événement est déjà passé")
    end
  end

  validates :duration, presence: true

  validate :is_multiple_of_5
  def is_multiple_of_5
    errors.add(:duration, "must be multiple of 5 and greater or equal to 5") unless
        duration % 5 == 0
  end

  validates :title, presence: true, length: { in: 4..140 }

  validates :description, presence: true, length: { in: 20..1000 }

  validates :price,
    presence: true,
    numericality: {
      greater_than: 1,
      less_than: 1000
    }

  validates :location, presence: true
end
