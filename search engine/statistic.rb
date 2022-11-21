class Statistic
  SEARCH_FIELDS = [:make, :model,
                  :year_from, :year_to,
                  :price_from, :price_to]

  def initialize(user_data, results_car, stat)
    @stat = stat
    @results_car = results_car
    @user_data = user_data
  end

  def call
    if File.exist?("./.db/searches.yml")
      @stat = YAML.load_file('./.db/searches.yml')
    else
      File.new("./.db/searches.yml", "w")
    end

    match_index = @stat.index { |stat_req| @user_data.slice(*SEARCH_FIELDS) == stat_req.slice(*SEARCH_FIELDS)}
    if @stat.empty? || match_index.nil?
      save_search = @user_data.slice(*SEARCH_FIELDS)
      save_search[:requests_quantity] = 1
      save_search[:total_qantity] = @results_car.size
      @stat.push(user_search)
      File.open("./.db/searches.yml", 'w') { |f| YAML.dump(@stat, f) }
    else
      @stat[match_index][:requests_quantity] += 1
      @stat[match_index][:total_qantity] = @results_car.size
      File.open("./.db/searches.yml", 'w') { |f| YAML.dump(@stat, f) }
      @stat[match_index][:requests_quantity]
    end
  end
end
