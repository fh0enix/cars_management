class Formatting
  def initialize(data, user_data)
    @data = data
    @result_data = user_data
    @make = []
    @model = []
  end

  def call
    @result_data[:sort_direction] = 'desc' if @result_data[:sort_direction] != 'asc'
    @result_data[:sort_option] = 'date_added' if @result_data[:sort_option] != 'price'

    @data.each do |car|
      @make << car[:make].upcase
      @model << car[:model].upcase
    end

    @result_data[:make] = nil if @make.include?(@result_data[:make]) == false
    @result_data[:model] = nil if @model.include?(@result_data[:model]) == false
    @result_data
  end
end
