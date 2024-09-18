# app/controllers/api/v1/sessions_controller.rb
class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token  # Skip CSRF token verification for API requests

  # POST /api/v1/login
  def create
    resource = warden.authenticate!(auth_options)
    token = JwtService.encode(user_id: resource.id)
    render json: { token: token }, status: :ok
  end

  # DELETE /api/v1/logout
  def destroy
    # Token-based sign-out usually does not involve server-side invalidation
    head :no_content
  end

  private

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
