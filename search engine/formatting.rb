class Formatting
  def initialize(data, user_data)
    @data = data
    @result_data = user_data
    @make = []
    @model = []
  end

  def call
    @data.each do |car|
      @make << car[:make].upcase
      @model << car[:model].upcase
    end

    @result_data[:make] = nil unless @make.include?(@result_data[:make])
    @result_data[:model] = nil unless @model.include?(@result_data[:model])
    @result_data
  end
end
