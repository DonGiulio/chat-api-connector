# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sample test' do
  it 'succeeds' do
    expect(true).to eq(true)
  end

  it 'faker working' do
    expect(Faker::Name.name).to be_a(String)
  end

  it 'factorybot working' do
    expect(build(:profile)).to be_a(Profile)
  end

  it 'redis cache_store' do
    cache_store = Rails.application.config.cache_store
    expect(cache_store.first).to eq(:redis_cache_store)
    expect(cache_store.last[:url]).to start_with('redis://')
  end

  it 'cache working' do
    Rails.cache.write('key', 'value')
    expect(Rails.cache.read('key')).to eq('value')
  end
end
