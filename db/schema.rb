# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150928100628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bishops", force: :cascade do |t|
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "pawn_id"
    t.integer  "king_id"
    t.integer  "queen_id"
    t.integer  "bishop_id"
    t.integer  "knight_id"
    t.integer  "rook_id"
    t.integer  "cell_id"
  end

  add_index "boards", ["bishop_id"], name: "index_boards_on_bishop_id", using: :btree
  add_index "boards", ["cell_id"], name: "index_boards_on_cell_id", using: :btree
  add_index "boards", ["king_id"], name: "index_boards_on_king_id", using: :btree
  add_index "boards", ["knight_id"], name: "index_boards_on_knight_id", using: :btree
  add_index "boards", ["pawn_id"], name: "index_boards_on_pawn_id", using: :btree
  add_index "boards", ["queen_id"], name: "index_boards_on_queen_id", using: :btree
  add_index "boards", ["rook_id"], name: "index_boards_on_rook_id", using: :btree

  create_table "cells", force: :cascade do |t|
    t.string   "position"
    t.boolean  "occupied?"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kings", force: :cascade do |t|
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "knights", force: :cascade do |t|
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pawns", force: :cascade do |t|
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "queens", force: :cascade do |t|
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooks", force: :cascade do |t|
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "boards", "bishops"
  add_foreign_key "boards", "cells"
  add_foreign_key "boards", "kings"
  add_foreign_key "boards", "knights"
  add_foreign_key "boards", "pawns"
  add_foreign_key "boards", "queens"
  add_foreign_key "boards", "rooks"
end
