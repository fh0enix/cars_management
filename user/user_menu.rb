# frozen_string_literal: true

class UserMenu
  def initialize(user_auth)
    @user_auth = user_auth
  end

  def run
    loop do
      show_menu
      choose_menu_item
    end
  end

  def show_menu
    puts I18n.t(:user_helper).green
    puts I18n.t(:search_car)
    puts I18n.t(:show_all_cars)
    puts I18n.t(:help)
    puts I18n.t(:user_exit)
  end

  def choose_menu_item
    case gets.to_i
    when 1 then SearchEngine.new.run
    when 2 then AllCars.new.call
    when 3 then puts I18n.t(:help_txt)
    when 4 then puts I18n.t(:see_you_later)
    else puts I18n.t(:error).white.on_red
    end
  end
end
