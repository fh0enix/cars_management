require 'yaml'
require_relative 'preprocessing'
require_relative 'formatting'
require_relative 'printer'
require_relative 'sorting'
require_relative 'result_car'

class SearchEngine
  def initialize
	 @data = YAML.safe_load_file('./db/db.yml', symbolize_names: true)
	 @user_data = {}
	 @results_car = []
  end

  def run
    @user_data = Preprocessing.new(@user_data).result_data
    puts @user_data
    @user_data = Formatting.new(@data, @user_data).result_data
    puts @user_data
    @results_car = ResultCar.new(@data, @user_data).results_car
    puts @results_car
    @results_car = Sorting.new(@user_data, @results_car).results_car
    puts @results_car
    Printer.new(@results_car).results
  end
end



