# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_viewing_parties, dependent: :destroy
  has_many :viewing_parties, through: :user_viewing_parties, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_secure_password

  enum role: %w(default user)

  def self.authenticate(email,password)
    user = User.find_by(email: email.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end