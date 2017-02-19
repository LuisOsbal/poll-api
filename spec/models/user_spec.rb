require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should_not allow_value('email@domain').for(:email) }
  it { should allow_value('email@domain.com').for(:email) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }

  it "Should creates a new user if uid and the provider doesn't exist" do
    expect do
      User.from_omniauth(
        uid: '12345',
        provider: 'Github',
        info: {
          email: 'email@domain.com'
        }
      )
    end.to change(User, :count).by(1)
  end

  it 'Should finds a user if the uid and the provider exists' do
    user = FactoryGirl.create(:user)
    expect do
      User.from_omniauth(
        uid: user.uid,
        provider: user.provider
      )
    end.to change(User, :count).by(0)
  end

  it 'Should goes back the user if the uid and the provider exists' do
    user = FactoryGirl.create(:user)
    expect(
      User.from_omniauth(
        uid: user.uid,
        provider: user.provider
      )
    ).to eq(user)
  end
end
