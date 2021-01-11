# frozen_string_literal: true

require 'rails_helper'

describe CnabServices::Process do
  context 'when service receives a file content' do
    let(:file) do
      File.read(Rails.root.join('spec', 'support', 'CNAB.txt'))
    end

    it 'should process and create shop with transactions' do
      subject = described_class.call(file)

      expect(subject.success?).to be true
      expect(Shop.count).to eq(5)
      expect(Transaction.count).to eq(21)
    end
  end

  context 'when service receives a invalid file content' do
    let(:file) do
      File.read(Rails.root.join('spec', 'support', 'CNAB_INVALID.txt'))
    end

    it 'should process and returned error' do
      subject = described_class.call(file)

      expect(subject.success?).to be false
      expect(subject.error).to eq("Error with reader line 320190301000001420009010000000001420000001420000001420\n")
      expect(Shop.count).to eq(0)
      expect(Transaction.count).to eq(0)
    end
  end
end
