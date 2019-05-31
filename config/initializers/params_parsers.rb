ActionDispatch::Request.parameter_parsers = ActionDispatch::Request.parameter_parsers.merge(
  Mime[:json].symbol => -> (raw_post) {
    ::JSON.parse(raw_post).tap do |res|
      begin
        unless Hash === res or Array === res
          raise StandardError.new "Expecting a hash or array"
        end
      rescue
        raise ActionDispatch::Http::Parameters::ParseError
      end
    end
  }
)

class CatchJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue ActionDispatch::Http::Parameters::ParseError => error
      if env['action_dispatch.request.content_type'] == Mime[:json]
        error_output = "There was a problem in the JSON you submitted: #{error}"
        return [
          400, { "Content-Type" => "application/json" },
          [ { status: 400, error: error_output }.to_json ]
        ]
      else
        raise error
      end
    end
  end
end

Rails.application.configure do
  config.middleware.use CatchJsonParseErrors
end

