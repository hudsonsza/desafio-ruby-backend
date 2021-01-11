# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Shops', type: :request do
  describe 'GET /' do
    context 'success' do
      it 'is a successfull request' do
        get '/'
        expect(response).to be_successful
        expect(response.body).to include('Shops')
      end
    end
  end

  describe 'GET /' do
    context 'success' do
      let(:file) do
        File.read(Rails.root.join('spec', 'support', 'CNAB.txt'))
      end

      let!(:service) do
        CnabServices::Process.call(file)
      end

      it 'has a MERCADO DA AVENIDA shop' do
        get '/'
        expect(response).to be_successful
        expect(response.body).to include('MERCADO DA AVENIDA')
      end
    end
  end
end
