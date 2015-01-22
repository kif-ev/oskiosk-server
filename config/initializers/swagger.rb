class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    # Make a distinction between the APIs and API documentation paths.
      "docs/#{path}"
    end
  end

Swagger::Docs::Config.base_api_controller = ActionController::API

Swagger::Docs::Config.register_apis({
  "current" => {
    # the extension used for the API
    :api_extension_type => :json,
    # the output location where your .json files are written to
    :api_file_path => "public/docs",
    # the URL base path to your API
    :base_path => "https://oskiosk.herokuapp.com",
    # if you want to delete all .json files at each generation
    :clean_directory => false,
    # add custom attributes to api-docs
    :attributes => {
      :info => {
        "title" => "OSKiosk",
        "description" => "Backend for a german Kiosk",
        "contact" => "felix@fachschaften.org"
      }
    }
  }
})
