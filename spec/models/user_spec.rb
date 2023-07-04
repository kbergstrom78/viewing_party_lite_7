require 'rails_helper'

RSpec.describe User, type: :model do  
  describe 'relationships' do
    it { should have_many(:user_viewing_parties) }
    it { should have_many(:viewing_parties).through(:user_viewing_parties) }

    describe 'validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should validate_presence_of(:password) }
      it { should have_secure_password }
    end

    it 'can validate secure password' do  
      user = User.create(name: 'Bob', email: 'gaga@aol.com', password: '123', password_confirmation: '123')

      expect(user).to_not have_attributes(password: '123')
      expect(user.password_digest).to_not eq('123')
  end