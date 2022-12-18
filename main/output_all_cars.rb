# frozen_string_literal: true

require 'yaml'

class OutputAllCars < Output
  def initialize
    @results_car = YAML.safe_load_file(SearchEngine::DB_PATH, symbolize_names: true)
  end

  private

  def table_heading
    [I18n.t(:all), I18n.t(:cars)]
  end
end
