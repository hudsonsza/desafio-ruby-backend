# frozen_string_literal: true

require 'rails_helper'

describe CnabServices::ReaderLine do
  context 'when service receives a reader line' do
    let(:line) do
      '3201903010000019200845152540736777****1313172712MARCOS PEREIRAMERCADO DA AVENIDA'
    end

    it 'verify hash line returned' do
      expected_payload = {
        shop_name: 'MERCADO DA AVENIDA',
        shop_owner_name: 'MARCOS PEREIRA',
        transaction_type: 'financiamento'.to_sym,
        amount: 192,
        cpf: '84515254073',
        card_number: '6777****1313',
        traded_at: Time.zone.parse('2019-03-01 17:27:12')
      }

      subject = described_class.call(line)
      expect(subject.success?).to be true
      expect(subject.payload).to eq(expected_payload)
    end
  end

  context 'when service receives a reader line with invalid line' do
    let(:line) do
      '320190301'
    end

    it 'verify invalid returned' do
      subject = described_class.call(line)
      expect(subject.success?).to be false
    end
  end
end
