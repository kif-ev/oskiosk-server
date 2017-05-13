class IdentifiersController < ApplicationController
  # :nocov:
  swagger_controller :identifiers, 'Manage barcodes (identifiers)'

  swagger_api :show do
    summary 'Fetch a User or Product associated with this Barcode'
    notes <<-EON
      This will return a User or a Product depending on the scanned Barcode.
      The `type` attribute can be used to determine what is returned.
    EON
    param :path, :id, :string, :required, 'The Barcode value'
    response :ok, 'Success', :readProduct
    response :ok, 'Success', :readUser
    response :not_found
  end
  # :nocov:

  before_action :doorkeeper_authorize!

  def show
    identifiable = Identifier.find_by_code(params[:id]).try(:identifiable)

    if identifiable.present?
      render json: identifiable
    else
      render_not_found
    end
  end
end
