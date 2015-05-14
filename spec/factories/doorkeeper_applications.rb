FactoryGirl.define do
  factory :doorkeeper_application, class: Doorkeeper::Application do
    name 'foo'
    redirect_uri 'https://some/url'
  end
end
