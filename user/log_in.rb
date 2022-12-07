# frozen_string_literal: true

class LogIn < SignUp
  def call
    enter_email
    enter_password
    user_data_is_valid? ? show_user_menu : show_error
  end

  private

  def show_error
    puts I18n.t(:user_error).red
  end

  def enter_email
    puts I18n.t(:email_log_in)
    @user_data[:email] = gets.strip.to_s.downcaseS
  end

  def enter_password
    puts I18n.t(:password_log_in)
    @user_data[:password] = gets.strip.to_s
  end

  def show_user_menu
    puts I18n.t(:hello_user).red.on_white +
         @user_data[:email].upcase.black.on_white

    UserMenu.new(@user_data).run
  end

  def user_data_is_valid?
    check_db
    valid = false
    @users_db.each do |user|
      next unless user[:email] == @user_data[:email]
      next unless BCrypt::Password.new(user[:password]) == @user_data[:password]

      valid = true
    end
    valid
  end
end
