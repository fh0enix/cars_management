# frozen_string_literal: true

require 'i18n'
require 'colorize'

class Preprocessing
  ANSWER_OPTION = [' 0 ', ' 1 '].freeze
  LANG_OPTION = '<ENG>'

  def initialize(input_data)
    @result_data = input_data
  end

  def call
    puts I18n.t(:start).green
    make_model
    year
    price
    sort_option
    sort_direction
    @result_data
  end

  private

  def make_model
    puts I18n.t(:make, key: LANG_OPTION.yellow.on_red)
    @result_data[:make] = gets.strip.upcase
    puts I18n.t(:model, key: LANG_OPTION.yellow.on_blue)
    @result_data[:model] = gets.strip.upcase
  end

  def year
    puts I18n.t(:year_from)
    @result_data[:year_from] = gets.to_i
    puts I18n.t(:year_to)
    @result_data[:year_to] = gets.to_i
  end

  def price
    puts I18n.t(:price_from)
    @result_data[:price_from] = gets.to_i
    puts I18n.t(:price_to)
    @result_data[:price_to] = gets.to_i
  end

  def sort_option
    puts I18n.t(:sort_option,
                key0: ANSWER_OPTION[0].yellow.on_red,
                key1: ANSWER_OPTION[1].yellow.on_blue)
    @result_data[:sort_option] = gets.to_i
  end

  def sort_direction
    puts I18n.t(:sort_direction,
                key0: ANSWER_OPTION[0].yellow.on_red,
                key1: ANSWER_OPTION[1].yellow.on_blue)
    @result_data[:sort_direction] = gets.to_i
  end
end
