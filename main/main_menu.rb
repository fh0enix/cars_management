# frozen_string_literal: true

require 'colorize'
require 'i18n'
require_relative '../search engine/search_engine'
require_relative 'all_cars'

class MainMenu
  def run
    choose_language
    greet

    loop do
      show_menu
      choose_menu_item
    end
  end

  private

  def choose_menu_item
    case gets.to_i
    when 1 then SearchEngine.new.run
    when 2 then AllCars.new.call
    when 3 then puts I18n.t(:help_txt)
    when 4 then exit
    else puts I18n.t(:error).white.on_red
    end
  end

  def choose_language
    I18n.load_path += Dir["#{File.expand_path('locales')}/*.yml"]
    puts I18n.t(:select_lang, locale: :en).white.on_red +
         I18n.t(:select_lang, locale: :ua).white.on_blue
    I18n.locale = :ua if gets.strip.casecmp('U').zero?
  end

  def show_menu
    puts I18n.t(:helper).green
    puts I18n.t(:search_car)
    puts I18n.t(:show_all_cars)
    puts I18n.t(:help)
    puts I18n.t(:exit)
  end

  def greet
    puts I18n.t(:greeting)
  end
end
