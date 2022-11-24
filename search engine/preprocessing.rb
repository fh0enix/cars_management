require 'i18n'

class Preprocessing
  def initialize(user_data)
    @result_data = user_data
    I18n.load_path += Dir[File.expand_path("locales") + "/*.yml"]
  end

  def call
    print 'enter: <E> for English / введіть: <U> для Української: '
    I18n.locale = :ua if gets.strip.upcase == 'U'

    puts I18n.t(:start)
    print I18n.t(:make)
    @result_data[:make] = gets.strip.upcase

    print I18n.t(:model)
    @result_data[:model] = gets.strip.upcase

    print I18n.t(:year_from)
    @result_data[:year_from] = gets.to_i

    print I18n.t(:year_to)
    @result_data[:year_to] = gets.to_i

    print I18n.t(:price_from)
    @result_data[:price_from] = gets.to_i

    print I18n.t(:price_to)
    @result_data[:price_to] = gets.to_i

    print I18n.t(:sort_option)
    @result_data[:sort_option] = gets.strip.downcase

    print I18n.t(:sort_direction)
    @result_data[:sort_direction] = gets.strip.downcase

    @result_data
  end
end
