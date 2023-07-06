# frozen_string_literal: true

module Users
  class DiscoverController < ApplicationController
    def index
      @user = User.find(params[:user_id])
    end
  end
end
