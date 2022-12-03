# frozen_string_literal: true

require 'yaml'
require_relative 'preprocessing'
require_relative 'formatting'
require_relative 'printer'
require_relative 'sorting'
require_relative 'result_car'
require_relative 'statistic'

class SearchEngine
  CAR_DB = YAML.safe_load_file('./.db/db.yml', symbolize_names: true).freeze

  def initialize
    @data = CAR_DB
    @user_data = {}
    @results_car = []
    @stat = []
  end

  def run
    Preprocessing.new(@user_data).call
    Formatting.new(@data, @user_data).call
    ResultCar.new(@data, @user_data, @results_car).call
    Sorting.new(@user_data, @results_car).call
    Printer.new(@results_car, @user_data, @stat).call
  end
end
