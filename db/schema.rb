# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_111_184_607) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'shops', force: :cascade do |t|
    t.string 'name'
    t.string 'owner_name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'transactions', force: :cascade do |t|
    t.bigint 'shop_id', null: false
    t.integer 'transaction_type', null: false
    t.decimal 'amount'
    t.string 'cpf'
    t.string 'card_number'
    t.datetime 'traded_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['shop_id'], name: 'index_transactions_on_shop_id'
  end

  add_foreign_key 'transactions', 'shops'
end
