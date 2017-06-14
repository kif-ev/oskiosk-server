class TagAutocompletesController < ApplicationController
  before_action -> { doorkeeper_authorize! :admin }

  def index
    tags = []

    if key = params.keys.detect { |k| k.end_with?('_id') }
      type = key.gsub(/_id\z/, '').classify
      id = params[key].to_i

      tags = ActsAsTaggableOn::Tag.
             joins(:taggings).
             distinct.
             where(taggings: { taggable_type: type }).
             where.not(taggings: { taggable_id: id }).
             order(taggings_count: :desc).
             limit(10).
             named_like(params[:q] || '')
    end

    render json: tags, represent_with: TagsRepresenter
  end
end
