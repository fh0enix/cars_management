# frozen_string_literal: true

require 'colorize'
require 'i18n'
require_relative '../search engine/search_engine'
require_relative 'output_all_cars'
require_relative '../user/sign_up'
require_relative '../user/log_in'

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
    when 2 then OutputAllCars.new.call
    when 3 then puts I18n.t(:help_txt)
    when 4 then LogIn.new.call
    when 5 then SignUp.new.call
    when 6 then exit
    else puts I18n.t(:error)
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
    puts I18n.t(:log_in)
    puts I18n.t(:sign_up)
    puts I18n.t(:exit)
  end

  def greet
    puts I18n.t(:greeting)
  end
end
