# frozen_string_literal: true

require 'yaml'
require 'securerandom'
require 'i18n'
require 'colorize'
require_relative 'advert_preprocessing'

class AdminMenu
  include AdvertPreprosessing

  CAR_DB_PATH = '../.db/db.yml'
  TIME_FORMAT = '%Y/%m/%d'

  def initialize
    @car_db = YAML.safe_load_file(CAR_DB_PATH)
    @errors = []
  end

  def run
    until @car_db.nil?
      show_menu
      choose_menu_item
    end
  end

  private

  def show_menu
    puts I18n.t(:create_ad)
    puts I18n.t(:update_ad)
    puts I18n.t(:del_ad)
    puts I18n.t(:admin_log_out)
  end

  def choose_menu_item
    case gets.to_i
    when 1 then create_ad
    when 2 then update_ad
    when 3 then del_ad
    when 4 then @car_db = nil
    else puts I18n.t(:error).red
    end
  end

  def create_ad
    car = {}
    car[:id] = SecureRandom.uuid
    car_value(car)
    car[:date_added] = Time.new.strftime(TIME_FORMAT)
    @errors.nil? ? add_car_to_db(car) : show_errors
  end

  def car_value(car)
    car[:make] = make
    car[:model] = model
    car[:year] = year
    car[:odometer] = odometer
    car[:price] = price
    car[:description] = description
  end

  def update_ad
    puts I18n.t(:enter_id)
    ad_id = gets.strip
    index = mach_index(ad_id)
    index.nil? ? I18n.t(:index_nil_error, key: ad_id.yellow.on_red) : update_car(index)
  end

  def mach_index(ad_id)
    @car_db.index { |car| car[:id] == ad_id }
  end

  def update_car(index)
    car = @car_db[index]
    car_value(car)
    @errors.nil? ? update_car_in_db(index, car) : show_errors
  end

  def del_ad
    ad_id = gets.strip
    index = mach_index(ad_id)
    index.nil? ? I18n.t(:index_nil_error, key: ad_id.yellow.on_red) : car_delete(index)
  end

  def car_delete(index)
    I18n.t(:deleted_car_message, key: car_db[index][:id].yellow.on_red)
    @car_db.delete(index)
    File.write(CAR_DB_PATH, YAML.dump(@car_db))
  end

  def add_car_to_db(car)
    I18n.t(:created_car_message, key: car[:id].green.on_red)
    @car_db.push(car)
    File.write(CAR_DB_PATH, YAML.dump(@car_db))
  end

  def update_car_in_db(index, car)2
    @car_db[index].merge!(car)
    File.write(CAR_DB_PATH, YAML.dump(@car_db))
  end

  def show_errors
    @errors.each { |error| puts error.red }
  end
end
