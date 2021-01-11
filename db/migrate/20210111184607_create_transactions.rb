# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :shop, null: false, foreign_key: true
      t.integer :transaction_type, null: false
      t.decimal :amount
      t.string :cpf
      t.string :card_number
      t.datetime :traded_at
      t.timestamps
    end
  end
end
