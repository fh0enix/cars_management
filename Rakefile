# frozen_string_literal: true

require_relative 'admin/generate_car_db'

namespace :db do
  namespace :cars do
    desc 'Clear whole database of cars'
    task :clear do
      GenerateCarDb.new.cleer_db
    end

    desc 'Add one new record to car db'
    task :add_record do
      GenerateCarDb.new.add_rec
    end

    desc 'Add multiple records to car db'
    task :add_records, [:number] do |t, number|
      GenerateCarDb.new.add_rec(number[:number].to_i)
    end
  end
end
