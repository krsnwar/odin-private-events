class Event < ApplicationRecord
  belongs_to :user
  has_many :event_atendees
  has_many :atendee, through: :event_atendees, source: :user

  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
end
