require 'colorize'

class Preprocessing
  ANSWER_OPTION = [" 0 ", " 1 "]
  LANG_OPTION = '<ENG>'
  def initialize(user_data)
    @result_data = user_data
    I18n.load_path += Dir[File.expand_path("locales") + "/*.yml"]
  end

  def call
    puts I18n.t(:select_lang, locale: :en).yellow.on_red +
          I18n.t(:select_lang, locale: :ua).yellow.on_blue
    I18n.locale = :ua if gets.strip.upcase == 'U'

    puts I18n.t(:start)

    puts I18n.t(:make, key: LANG_OPTION.yellow.on_red)
    @result_data[:make] = gets.strip.upcase

    puts I18n.t(:model, key: LANG_OPTION.yellow.on_blue)
    @result_data[:model] = gets.strip.upcase

    puts I18n.t(:year_from)
    @result_data[:year_from] = gets.to_i

    puts I18n.t(:year_to)
    @result_data[:year_to] = gets.to_i

    puts I18n.t(:price_from)
    @result_data[:price_from] = gets.to_i

    puts I18n.t(:price_to)
    @result_data[:price_to] = gets.to_i

    puts I18n.t(:sort_option, key0: ANSWER_OPTION[0].yellow.on_red,
                               key1: ANSWER_OPTION[1].yellow.on_blue)
    @result_data[:sort_option] = gets.to_i

    puts I18n.t(:sort_direction, key0: ANSWER_OPTION[0].yellow.on_red,
                                  key1: ANSWER_OPTION[1].yellow.on_blue)
    @result_data[:sort_direction] = gets.to_i

    @result_data
  end
end
