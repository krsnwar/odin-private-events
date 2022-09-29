class User < ApplicationRecord
  has_many :events
  has_many :event_atendees
  has_many :events_atended, through: :event_atendees, source: :event
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
