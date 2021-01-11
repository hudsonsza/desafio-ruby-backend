# frozen_string_literal: true

class Transaction < ApplicationRecord
  OPERATIONS = {
    positives: %i[debito credito recebimento_emprestimo vendas recebimento_ted],
    negatives: %i[boleto financiamento aluguel]
  }.freeze

  belongs_to :shop

  enum transaction_type: {
    debito: 1,
    boleto: 2,
    financiamento: 3,
    credito: 4,
    recebimento_emprestimo: 5,
    vendas: 6,
    recebimento_ted: 7,
    recebimento_doc: 8,
    aluguel: 9
  }

  scope :positives, -> { where(transaction_type: OPERATIONS[:positives]) }
  scope :negatives, -> { where(transaction_type: OPERATIONS[:negatives]) }

  def positive?
    OPERATIONS[:positives].include? transaction_type.to_sym
  end

  def negative?
    OPERATIONS[:negatives].include? transaction_type.to_sym
  end
end
