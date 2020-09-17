class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, confirmation: true, allow_nil: true

  has_many :orders

  has_secure_password

  enum role: %w(default merchant admin)
end
