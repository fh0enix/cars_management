# frozen_string_literal: true

class UserMenu < MainMenu
  def run
    choose_language
    greet

    loop do
      show_menu
      choose_menu_item
    end
  end
end
