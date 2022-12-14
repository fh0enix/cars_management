# frozen_string_literal: true

require 'i18n'
require 'colorize'
require 'terminal-table'
require_relative 'statistic'

class Output
  TABLE_STYLES = { border_x: '='.colorize(color: :light_white, background: :green),
                   border_i: 'x'.colorize(color: :light_white, background: :green),
                   border_y: '|'.colorize(color: :light_white, background: :green),
                   border_bottom: false }.freeze

  def initialize(results_car, user_data, stat)
    @results_car = results_car
    @user_data = user_data
    @stat = stat
  end

  def call
    @table = Terminal::Table.new do |t|
      @results_car.each do |car|
        car.each { |row| t << row }
        t.add_separator
      end
      t.title = I18n.t(:results).white.on_red
      t.headings = table_heading
      t.style = TABLE_STYLES
    end
    puts @table
  end

  private

  def table_heading
    [[I18n.t(:total_quantity).white.on_red,
      @user_data[:total_qantity].to_s.white.on_red],
     [I18n.t(:requests_quantity).white.on_red,
      Statistic.new(@user_data, @results_car, @stat).call.to_s.white.on_red]]
  end
end
