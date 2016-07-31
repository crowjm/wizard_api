require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { FactoryGirl.create(:user) }

  let(:authenticated_user) do
    AuthenticateUser.new(user.email, user.password).call
  end

  subject { AuthorizeApiRequest.new(headers) }

  describe '#call' do
    context 'valid JWT is passed in request header' do
      let(:headers) do
        {
          'Authorization' => authenticated_user.result
        }
      end

      it 'returns the user in the result' do
        expect(subject.call.result).to eq(user)
      end

      it 'populates no errors' do
        expect(subject.call.errors).to be_empty
      end
    end

    context 'invalid JWT is passed in request header' do
      let(:headers) do
        {
          'Authorization' => 'bad jwt'
        }
      end

      it 'returns the user in the result' do
        expect(subject.call.result).to eq(nil)
      end

      it 'populates no errors' do
        expect(subject.call.errors)
          .to include(:token)
      end
    end
  end
end
