# frozen_string_literal: true

class LogIn < SignUp
  def call
    enter_email
    enter_password
    input_data_is_valid ? show_user_menu : show_error
  end

  private

  def show_error
    puts I18n.t(:user_error).red
  end

  def enter_email
    puts I18n.t(:email_log_in)
    @input_data[:email] = gets.strip.downcase
  end

  def enter_password
    puts I18n.t(:password_log_in)
    @input_data[:password] = gets.strip
  end

  def show_user_menu
    puts I18n.t(:hello_user).red.on_white +
         @input_data[:email].upcase.black.on_white

    UserMenu.new(@input_data[:email]).run
  end

  def input_data_is_valid
    check_db

    @users_db.each do |user|
      next unless user[:email] == @input_data[:email]
      next unless BCrypt::Password.new(user[:password]) == @input_data[:password]

      return true
    end
    false
  end
end
