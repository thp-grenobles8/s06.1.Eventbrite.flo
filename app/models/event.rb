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

  validate :duration_modulo_5
  def duration_modulo_5
    if !(self.duration % 5 == 0 && self.duration >= 5)
      errors.add("doit être un multiple de 5")
    end
  end

  validates :title, presence: true, length: { in: 5..140 }

  validates :description, presence: true, length: { in: 20..1000 }

  validates :price,
    presence: true,
    numericality: {
      greater_than: 1,
      less_than: 1000
    }

  validates :location, presence: true
end
