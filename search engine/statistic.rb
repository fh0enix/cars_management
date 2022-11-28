# frozen_string_literal: true

class Statistic
  SEARCH_FIELDS = %i[make model year_from year_to price_from price_to].freeze
  def initialize(user_data, results_car, stat)
    @stat = stat
    @results_car = results_car
    @user_data = user_data
  end

  def call
    if File.exist?('./.db/searches.yml')
      @stat = YAML.load_file('./.db/searches.yml')
    else
      File.new('./.db/searches.yml', 'w')
    end
    match_index = @stat.index { |stat_req| @user_data.slice(*SEARCH_FIELDS) == stat_req.slice(*SEARCH_FIELDS) }
    if @stat.empty? || match_index.nil?
      save_search = @user_data.slice(*SEARCH_FIELDS)
      save_search[:requests_quantity] = 1
      save_search[:total_qantity] = @results_car.size
      @stat.push(save_search)
      File.write('./.db/searches.yml', YAML.dump(@stat))
      @stat[0][:requests_quantity]
    else
      @stat[match_index][:requests_quantity] += 1
      @stat[match_index][:total_qantity] = @results_car.size
      File.write('./.db/searches.yml', YAML.dump(@stat))
      @stat[match_index][:requests_quantity]
    end
  end
end
