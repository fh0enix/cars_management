# frozen_string_literal: true

require 'ffaker'
require 'securerandom'
require 'yaml'

class GenerateCarDb
  CAR_DB_PATH = './.db/db.yml'
  TAIL_OF_HEX = '-330f-11ec-8d3d-0242ac130003'
  def initialize
    @car_db = []
  end


  def add_records(number)
    check_db
    number.times do
      @car_db.push(fake_car)
    end
    File.write(CAR_DB_PATH, YAML.dump(@car_db))
  end

  def ask_question
    puts 'Enter number of cars to be added: '
    input
  end

  def add_record
    check_db
    @car_db.push(fake_car)
    File.write(CAR_DB_PATH, YAML.dump(@car_db))
  end

  def cleer_db
    File.write(CAR_DB_PATH, YAML.dump(@car_db))
  end

  private

  def input
    $stdout.flush
    number = $stdin.gets.chomp.to_i
    add_records(number)
  end

  def fake_car
    {
      id: random_hex,
      make: FFaker::Vehicle.make,
      model: FFaker::Vehicle.model,
      year: FFaker::Vehicle.year.to_i,
      odometer: rand(15_000..120_000),
      price: rand(1000..50_000),
      description: FFaker::Lorem.phrase,
      date_added: Date.now
    }
  end

  def random_hex
    SecureRandom.hex(4) + TAIL_OF_HEX
  end

  def check_db
    @car_db = YAML.load_file(CAR_DB_PATH) if File.exist?(CAR_DB_PATH)
  end
end