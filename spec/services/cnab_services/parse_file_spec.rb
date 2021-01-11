# frozen_string_literal: true

require 'rails_helper'

describe CnabServices::ParseFile do
  context 'when service receives a file content' do
    let(:file) do
      File.read(Rails.root.join('spec', 'support', 'CNAB.txt'))
    end

    it 'should parse file with results' do
      subject = described_class.call(file)

      expect(subject.success?).to be true
      expect(subject.payload.count).to eq(21)
    end
  end
end
