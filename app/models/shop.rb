# frozen_string_literal: true

class Shop < ApplicationRecord
  has_many :transactions

  validates :name, :owner_name, presence: true

  def total_balance
    positive = transactions.positives.sum('amount')
    negative = transactions.negatives.sum('amount')

    positive - negative
  end
end
