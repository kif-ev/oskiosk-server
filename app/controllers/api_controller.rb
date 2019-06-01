class APIController < ApplicationController
  include ActionController::ImplicitRender
  include ActionController::MimeResponds
  include Roar::Rails::ControllerAdditions
  include Roar::Rails::ControllerAdditions::Render

  class UnprocessableRequest < StandardError; end

  rescue_from UnprocessableRequest, with: :render_unprocessable

  def render_not_found
    render json: {message: 'Resource not found'}, status: :not_found
  end

  def render_unprocessable
    render json: { message: 'Invalid request' }, status: :unprocessable_entity
  end

end
