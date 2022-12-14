# frozen_string_literal: true

class Statistic
  SEARCH_FIELDS = %i[make model year_from year_to price_from price_to].freeze
  STAT_FIELDS = %i[user make model year_from year_to price_from price_to].freeze
  SEARCH_DB_PATH = './.db/searches.yml'
  SESSION_TIME = Time.new.strftime('%Y-%m-%d %H:%M')

  def initialize(user_data, results_car, stat)
    @stat = stat
    @results_car = results_car
    @user_data = user_data
  end

  def call
    check_db
    match_index = @stat.index { |stat_req| @user_data.slice(*SEARCH_FIELDS) == stat_req.slice(*SEARCH_FIELDS) }
    if @stat.empty? || match_index.nil?
      create_new_stat
    else
      update_stat(match_index)
    end
  end

  private

  def check_db
    if File.exist?(SEARCH_DB_PATH)
      @stat = YAML.load_file(SEARCH_DB_PATH)
    else
      File.new(SEARCH_DB_PATH, 'w')
    end
  end

  def create_new_stat
    save_search = @user_data.slice(*STAT_FIELDS)
    save_search[:requests_quantity] = 1
    save_search[:total_qantity] = @results_car.size
    save_search[:user][0][:time] = SESSION_TIME
    @stat.push(save_search)
    File.write(SEARCH_DB_PATH, YAML.dump(@stat))
    @stat[0][:requests_quantity]
  end

  def update_stat(match_index)
    @stat[match_index][:requests_quantity] += 1
    @stat[match_index][:total_qantity] = @results_car.size
    update_user(match_index)
    File.write(SEARCH_DB_PATH, YAML.dump(@stat))
    @stat[match_index][:requests_quantity]
  end

  def update_user(match_index)
    @user_data[:user][0][:time] = SESSION_TIME
    @stat[match_index][:user].push(@user_data[:user][0])
  end
end
