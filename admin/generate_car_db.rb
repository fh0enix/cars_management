require 'ffaker'
require 'securerandom'
require 'yaml'

class GenerateCarDb
  CAR_DB_PATH = './.db/db.yml'
  def initialize
  @car_db = []
  end

  def add_one_new_record
    check_db
    @car_db.push(fake_car)
    File.write(CAR_DB_PATH, YAML.dump(@car_db))
  end

  def add_multiple_records(number)
    check_db
    number.times do
      @car_db.push(fake_car)
    end
    File.write(CAR_DB_PATH, YAML.dump(@car_db))
  end

  def cleer_db
    File.write(CAR_DB_PATH, YAML.dump(@car_db))
  end

  private

  def fake_car
    {
      id: random_hex,
      make: FFaker::Vehicle.make,
      model: FFaker::Vehicle.model,
      year: FFaker::Vehicle.year.to_i,
      odometer: rand(15000..120000),
      price: rand(1000..50000),
      description: FFaker::Lorem.phrase,
      date_added: random_date
    }
  end

  def random_date
    "#{rand(1..28)}/#{rand(1..12)}/#{rand(1999..2022)}"
  end

  def random_hex
    "#{SecureRandom.hex(4)}-330f-11ec-8d3d-0242ac130003"
  end

  def check_db
    @car_db = YAML.load_file(CAR_DB_PATH) if File.exist?(CAR_DB_PATH)
  end
end

