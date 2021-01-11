# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  describe 'GET /' do
    context 'success' do
      it 'is a successfull request' do
        get '/'
        expect(response).to be_successful
        expect(response.body).to include('Shops')
      end
    end
  end

  describe 'GET /shops/1/transactions' do
    context 'success' do
      let(:file) do
        File.read(Rails.root.join('spec', 'support', 'CNAB.txt'))
      end

      let!(:service) do
        CnabServices::Process.call(file)
      end

      let!(:shop) { Shop.first }

      it 'has a financiamento transactions' do
        get "/shops/#{shop.id}/transactions"
        expect(response).to be_successful
        expect(response.body).to include('financiamento')
      end
    end
  end
end
