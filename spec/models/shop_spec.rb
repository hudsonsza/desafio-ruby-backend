# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:owner_name) }
  end

  describe 'associations' do
    it { should have_many(:transactions) }
  end

  describe '#total_balance' do
    it 'return a positive value of sum from all transactions' do
      shop = FactoryBot.create(:shop)
      transaction = FactoryBot.create(:transaction, shop: shop,
                                                    transaction_type: 2, amount: 100.00)
      transaction2 = FactoryBot.create(:transaction, shop: shop,
                                                     transaction_type: 1, amount: 250.00)

      expect(shop.total_balance).to eq(150.00)
    end

    it 'return a negative value of sum from all transactions' do
      shop = FactoryBot.create(:shop)
      transaction = FactoryBot.create(:transaction, shop: shop,
                                                    transaction_type: 2, amount: 100.00)
      transaction2 = FactoryBot.create(:transaction, shop: shop,
                                                     transaction_type: 2, amount: 250.00)

      expect(shop.total_balance).to eq(-350.00)
    end
  end
end
