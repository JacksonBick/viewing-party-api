class ViewingParty < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_and_belongs_to_many :users
end