# frozen_string_literal: true

require 'colorize'
require 'i18n'
require_relative '../search engine/search_engine'
require_relative 'all_cars'

class MainMenu
  def run
    lang_choice
    greeting

    loop do
      choice_menu
      case_choice
    end
  end

  private

  def case_choice
    case gets.to_i
    when 1 then SearchEngine.new.run
    when 2 then AllCars.new.call
    when 3 then puts I18n.t(:help_txt)
    when 4 then go_exit
    else puts I18n.t(:error).white.on_red
    end
  end

  def lang_choice
    I18n.load_path += Dir["#{File.expand_path('locales')}/*.yml"]
    puts I18n.t(:select_lang, locale: :en).white.on_red +
         I18n.t(:select_lang, locale: :ua).white.on_blue
    I18n.locale = :ua if gets.strip.casecmp('U').zero?
  end

  def choice_menu
    puts I18n.t(:helper).green
    puts I18n.t(:search_car)
    puts I18n.t(:show_all_cars)
    puts I18n.t(:help)
    puts I18n.t(:exit)
  end

  def go_exit
    print I18n.t(:bye)
    33.times do
      sleep 0.05
      print '.'
    end
    puts
    exit
  end

  def greeting
    puts I18n.t(:greeting)
  end
end
