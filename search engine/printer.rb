require_relative 'statistic'
require 'i18n'
require 'terminal-table'
require 'colorize'

class Printer
  def initialize(results_car, user_data, stat)
    @results_car = results_car
    @user_data = user_data
    @stat = stat
  end

  def call
    stat = Terminal::Table.new do |t|
      t.style = { alignment: :center, width: 60, border_x: '=', border_i: 'x' }
      t.title = I18n.t(:statistic).colorize(:green)
      t << [I18n.t(:total_quantity), @user_data[:total_qantity]]
      t << [I18n.t(:requests_quantity), Statistic.new(@user_data, @results_car, @stat).call]
    end

    table = Terminal::Table.new do |t|
      t.style = { border_x: '=', border_i: 'x' }
      t.title = I18n.t(:results).colorize(:green)
      @results_car.each { |car| car.each { |row| t << row } }
    end
    puts stat
    puts table
  end
end
