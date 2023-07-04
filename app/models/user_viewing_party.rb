# frozen_string_literal: true

class UserViewingParty < ApplicationRecord
  belongs_to :user
  belongs_to :viewing_party
end
