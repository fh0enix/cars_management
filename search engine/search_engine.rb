# frozen_string_literal: true

require 'yaml'
require_relative 'preprocessing'
require_relative 'formatting'
require_relative 'output'
require_relative 'sorting'
require_relative 'result_car'
require_relative 'statistic'

class SearchEngine
  DB_PATH = './.db/db.yml'

  def initialize(user = nil)
    @user = user
    @data = YAML.safe_load_file(DB_PATH, symbolize_names: true)
    @input_data = { user: [{ ID: @user, time: nil }] }
    @results_car = []
    @stat = []
  end

  def run
    Preprocessing.new(@input_data).call
    Formatting.new(@data, @input_data).call
    ResultCar.new(@data, @input_data, @results_car).call
    Sorting.new(@input_data, @results_car).call
    Output.new(@results_car, @input_data, @stat).call
  end
end
