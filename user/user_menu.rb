# frozen_string_literal: true

require_relative 'user_searches'

class UserMenu
  def initialize(user)
    @user = user
  end

  def run
    until @user.nil?
      show_menu
      choose_menu_item
    end
  end

  private

  def show_menu
    puts I18n.t(:helper).green
    puts I18n.t(:search_car)
    puts I18n.t(:show_all_cars)
    puts I18n.t(:help)
    puts I18n.t(:my_searches)
    puts I18n.t(:user_log_out)
    puts I18n.t(:exit)
  end

  def choose_menu_item
    case gets.to_i
    when 1 then SearchEngine.new(@user).run
    when 2 then AllCars.new.call
    when 3 then puts I18n.t(:help_txt)
    when 4 then UserSearches.new(@user).call
    when 5 then log_out
    when 6 then exit
    else puts I18n.t(:error).red
    end
  end

  def log_out
    puts I18n.t(:see_you_later).white.on_blue
    @user = nil
  end
end
