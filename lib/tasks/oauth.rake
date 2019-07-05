# for some reason not everything we'd need gets autloded on itself
# https://github.com/kif-ev/oskiosk-server/issues/141
require 'active_record/base'

namespace :oauth do
  desc 'Create a new application/oauth_token'
  task :create_app, [:name, :type] => [:environment] do |t,args|
    app_name = args[:name]
    scopes = 'public checkout'
    case args[:type]
    when 'deposit'
      scopes << ' deposit'
    when 'admin'
      scopes << ' deposit admin'
    end
    raise(ArgumentError, 'no app name given') unless app_name.present?

    app = Doorkeeper::Application.create(
      name: app_name,
      # magic redirect_url for standalone apps because OAuth…
      redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
    )
    token = Doorkeeper::AccessToken.create(
      application: app,
      scopes: scopes
    )

    puts "Token for #{app.name}:"
    puts token.token
  end
end
