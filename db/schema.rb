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

ActiveRecord::Schema[7.1].define(version: 20_240_227_171_123) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'messages', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.text 'content'
    t.uuid 'profile_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'sender'
    t.index ['profile_id'], name: 'index_messages_on_profile_id'
  end

  create_table 'profiles', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.integer 'gender'
    t.string 'category'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'messages', 'profiles'
end
