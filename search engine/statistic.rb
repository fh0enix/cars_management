class Statistic
  def initialize(user_data, stat)
    @stat = stat
    @user_data = user_data
  end

  def cleener
    @user_data = "make:#{@user_data[:make]}_" +
                 "model:#{@user_data[:model]}_" +
                 "year:#{@user_data[:year_from]}-#{@user_data[:year_to]}_" +
                 "price:#{@user_data[:price_from]}-#{@user_data[:price_to]}"
    @user_data.to_sym
    @user_data
  end

  def call
    if @stat.key?(cleener)
      @stat[@user_data] += 1
      File.open("./.db/searches.yml", 'w') { |f| YAML.dump(@stat, f) }
    else
      @stat[@user_data] = 1
      File.open("./.db/searches.yml", 'w') { |f| YAML.dump(@stat, f) }
    end
    @stat[@user_data]
  end
end
