class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :application, class_name: Doorkeeper::Application
  has_many :transaction_items, dependent: :destroy
end
