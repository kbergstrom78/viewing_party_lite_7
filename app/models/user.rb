# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_viewing_parties, dependent: :destroy
  has_many :viewing_parties, through: :user_viewing_parties, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  # validates :password, presence: true
  # has_secure_password
end
