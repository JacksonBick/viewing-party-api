class User < ApplicationRecord
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: { require: true }
  has_secure_password
  has_secure_token :api_key
  has_and_belongs_to_many :viewing_parties
  has_many :hosted_viewing_parties, class_name: 'ViewingParty', foreign_key: 'host_id'

  def hosted_viewing_parties
    ViewingParty.where(host_id: self.id)
  end


  def viewing_parties
    ViewingParty.joins(:users).where(users: { id: self.id })
  end
end
