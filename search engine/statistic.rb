class Statistic
  def initialize(user_data, results_car, stat)
    @stat = stat
    @results_car = results_car
    @user_data = user_data
  end

  def delete_add
    @user_data.delete(:sort_option)
    @user_data.delete(:sort_direction)
    @user_data[:requests_quantity] = 1
    @user_data[:id] = "ID_#{@user_data[:make]}" +
                 "#{@user_data[:model]}" +
                 "#{@user_data[:year_from]}#{@user_data[:year_to]}" +
                 "#{@user_data[:price_from]}#{@user_data[:price_to]}"
  end

  def call
    delete_add

    if File.exist?("./.db/searches.yml")
      @stat = YAML.load_file('./.db/searches.yml')
    else
      File.new("./.db/searches.yml", "w")
      @stat = [{SEARCHES: 'CAR'}]
    end

    if @stat.any? { |request| request.value?(@user_data[:id])}
      @stat.each do |request|
        if request.value?(@user_data[:id])
          request[:requests_quantity] += 1
          @user_data[:requests_quantity] = request[:requests_quantity]
        end
      end
    else
      @stat.push(@user_data)
    end

    File.open("./.db/searches.yml", 'w') { |f| YAML.dump(@stat, f) }

    @user_data[:requests_quantity]
  end
end
