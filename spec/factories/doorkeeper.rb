FactoryBot.define do
  factory :oauth_application, :class => Doorkeeper::Application do
    sequence(:name) {|n| n}
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
  end

  factory :oauth_token, :class => Doorkeeper::AccessToken do
    association :application, factory: :oauth_application
  end
end
