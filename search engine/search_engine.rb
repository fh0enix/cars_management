require 'yaml'
require_relative 'preprocessing'
require_relative 'formatting'
require_relative 'printer'
require_relative 'sorting'
require_relative 'result_car'
require_relative 'statistic'

class SearchEngine
  def initialize
   @data = YAML.safe_load_file('./.db/db.yml', symbolize_names: true)
   @stat = YAML.safe_load_file('./.db/searches.yml')
   @user_data = {}
   @results_car = []
  end

  def run
    Preprocessing.new(@user_data).call
    Formatting.new(@data, @user_data).call
    ResultCar.new(@data, @user_data, @results_car).call
    Sorting.new(@user_data, @results_car).call
    Printer.new(@results_car, @user_data, @stat).stat
    Printer.new(@results_car, @user_data, @stat).results
  end
end
