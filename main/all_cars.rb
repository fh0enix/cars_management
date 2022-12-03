# frozen_string_literal: true

require 'yaml'

class AllCars < Printer
  def initialize
    @results_car = SearchEngine::CAR_DB
  end

  private

  def table_heading
    [I18n.t(:all), I18n.t(:cars)]
  end
end
