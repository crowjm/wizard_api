require 'rails_helper'

RSpec.describe AuthenticateUser do
  let!(:user) { FactoryGirl.create(:user) }

  subject { AuthenticateUser.new(email, password) }

  describe '#call' do
    context 'valid email and password are provided' do
      let(:email) { user.email }
      let(:password) { user.password }

      it 'returns a JWT as in the result' do
        expect(subject.call.result.class).to be(String)
      end

      it 'populates no errors' do
        expect(subject.call.errors).to be_empty
      end
    end

    context 'invalid email and is provided' do
      let(:email) { 'wrong email' }
      let(:password) { user.password }

      it 'returns nil in the result' do
        expect(subject.call.result).to be_nil
      end

      it 'populates an error' do
        expect(subject.call.errors)
          .to include(:user_authentication)
      end
    end

    context 'invalid password and is provided' do
      let(:email) { user.email }
      let(:password) { 'wrong password' }

      it 'returns nil in the result' do
        expect(subject.call.result).to be_nil
      end

      it 'populates an error' do
        expect(subject.call.errors)
          .to include(:user_authentication)
      end
    end
  end
end
