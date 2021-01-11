# frozen_string_literal: true

module CnabServices
  class ReaderLine < ApplicationService
    TRANSACTION_TYPES = {
      1 => :debito,
      2 => :boleto,
      3 => :financiamento,
      4 => :credito,
      5 => :recebimento_emprestimo,
      6 => :vendas,
      7 => :recebimento_ted,
      8 => :recebimento_doc,
      9 => :aluguel
    }.freeze

    def initialize(line)
      @line = line
    end

    def call
      payload = formated_hash
    rescue StandardError => e
      OpenStruct.new({ success?: false, error: e.message })
    else
      OpenStruct.new({ success?: true, payload: payload })
    end

    def formated_hash
      {
        shop_name: shop_name.strip,
        shop_owner_name: shop_owner_name.strip,
        transaction_type: transaction_type,
        amount: amount,
        cpf: cpf.strip,
        card_number: card_number.strip,
        traded_at: traded_at
      }
    end

    def type
      @line[0].to_i
    end

    def transaction_type
      TRANSACTION_TYPES[type] || :not_found
    end

    def amount
      @line[9..18].to_i / 100
    end

    def traded_at
      Time.zone.parse(
        "#{@line[1..4]}-#{@line[5..6]}-#{@line[7..8]} #{@line[42..43]}:#{@line[44..45]}:#{@line[46..47]}"
      )
    end

    def cpf
      @line[19..29]
    end

    def card_number
      @line[30..41]
    end

    def shop_owner_name
      @line[48..61]
    end

    def shop_name
      @line[62..80]
    end
  end
end
