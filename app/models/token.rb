class Token < ApplicationRecord
  belongs_to :user
  before_create :generate_token

  def is_valid?
    DateTime.now < expires_at
  end

  private

  def generate_token
    loop do
      self.token = SecureRandom.hex
      break unless Token.where(token: token).any?
    end

    self.expires_at ||= 1.month.from_now
  end
end
