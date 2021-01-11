# frozen_string_literal: true

require 'rails_helper'

describe Transaction do
  describe 'associations' do
    let(:transaction) { described_class.new }

    it { expect(transaction).to belong_to(:shop) }
  end

  describe 'enums' do
    it {
      should define_enum_for(:transaction_type)
        .with_values(
          debito: 1,
          boleto: 2,
          financiamento: 3,
          credito: 4,
          recebimento_emprestimo: 5,
          vendas: 6,
          recebimento_ted: 7,
          recebimento_doc: 8,
          aluguel: 9
        )
    }
  end

  describe 'constants' do
    POSITIVES = %i[debito credito recebimento_emprestimo vendas
                   recebimento_ted].freeze
    NEGATIVES = %i[boleto financiamento aluguel].freeze

    it { expect(Transaction::OPERATIONS[:positives]).to eq(POSITIVES) }
    it { expect(Transaction::OPERATIONS[:negatives]).to eq(NEGATIVES) }
  end

  describe 'scopes' do
    describe 'positive_transactions' do
      it 'get all positive transactions based on transaction_type' do
        Transaction.delete_all

        FactoryBot.create(:transaction, transaction_type: 2)
        FactoryBot.create(:transaction, transaction_type: 1)

        result = Transaction.positives.count

        expect(result).to eq(1)
      end
    end

    describe 'negative_transactions' do
      it 'get all negative transactions based on transaction_type' do
        Transaction.delete_all

        FactoryBot.create(:transaction, transaction_type: 2)
        FactoryBot.create(:transaction, transaction_type: 2)
        FactoryBot.create(:transaction, transaction_type: 1)

        result = Transaction.negatives.count

        expect(result).to eq(2)
      end
    end
  end

  describe '#balance' do
    it 'return if transaction is positive value' do
      transaction = FactoryBot.create(:transaction, transaction_type: 1,
                                                    amount: 250.00)

      expect(transaction.positive?).to be true
      expect(transaction.negative?).to be false
    end

    it 'return if transaction is negative value' do
      transaction = FactoryBot.create(:transaction, transaction_type: 2,
                                                    amount: 100.00)

      expect(transaction.positive?).to be false
      expect(transaction.negative?).to be true
    end
  end
end
