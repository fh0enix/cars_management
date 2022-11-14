require 'yaml'
require_relative 'preprocessing'
require_relative 'formatting'
require_relative 'printer'
require_relative 'sorting'
require_relative 'result_car'

class SearchEngine
  def initialize
   @data = YAML.safe_load_file('./.db/db.yml', symbolize_names: true)
   @user_data = {}
   @results_car = []
  end

  def run
    Preprocessing.new(@user_data).call
    Formatting.new(@data, @user_data).call
    ResultCar.new(@data, @user_data, @results_car).call
    Sorting.new(@user_data, @results_car).call
    Printer.new(@results_car).results
  end
end
