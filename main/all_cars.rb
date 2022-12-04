# frozen_string_literal: true

require 'yaml'

class AllCars < Printer
  def initialize
    @results_car = YAML.safe_load_file(SearchEngine::PATH_TO_DB, symbolize_names: true)
  end

  private

  def table_heading
    [I18n.t(:all), I18n.t(:cars)]
  end
end
