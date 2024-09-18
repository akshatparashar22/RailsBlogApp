# app/controllers/api/v1/base_controller.rb
class Api::V1::BaseController < ApplicationController
    before_action :authenticate_user!
  
    # Optional: Custom method to handle unauthorized access
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
    private
  
    def not_found
      render json: { error: 'Resource not found' }, status: :not_found
    end
  end
  