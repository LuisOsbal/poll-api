class User < ApplicationRecord
  validates :email, presence: true, email: true
  validates :uid, presence: true
  validates :provider, presence: true
  has_many :tokens

  # This method receives a hash of data.
  # Ex: { provider: 'Github', uid: '12345', info: { email: 'email@domain.com',
  # name: 'Luis' } }
  def self.from_omniauth(data)
    User.where(
      provider: data[:provider],
      uid: data[:uid]
    ).first_or_create do |user|
      user.email = data[:info][:email]
    end
  end
end
