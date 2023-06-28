# frozen_string_literal: true

class SupportsController < ApplicationController
  def home
    render json: { app: 'zane-office-api', version: '0.0.1' }
  end
end
