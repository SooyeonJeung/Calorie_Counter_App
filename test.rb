require "csv"

puts "Welcome to the app"
class Test
    attr_accessor :date, :calories
        def initialize
            @date = date
            @calories = calories
        end

        def self.run
            puts "Enter the date"
            @date = gets.chomp
            puts "Enter the calories"
            @calories = gets.chomp.to_i

            user_data = []
            user_data << [@date, @calories]

            file_name = 'food_calorie_file.csv'
            CSV.open(file_name, 'w') do |csv|
                csv << [@date, calories]
              end
        end

        def self.import(path:)
            CSV.read('food_calorie_file.csv', headers: true).map do |row|
              Food_item.new(
                food: row["food_item"],
                calorie: row["calorie"].to_i,
              )
            end
        end
end

Test.new.import





# CSV.open('data.csv', 'a+') do |row|
#     row << person
# end



# CSV.open(file_name', 'w') << %w(date total_calories)
# CSV.open('data.csv', 'a+') do |row|
#     row << person
# end



# csv << %w(Nov, 200)
# csv << %w(Oct, 210)
# csv << %w(Dec, 400)

# file = CSV.read('fixed_data.csv', headers: true, header_converters: :symbol)
# file.each_with_index do |row, i|
#     @date = row[:date]
#     total_calories = row[:calories]
# end



# file.each {|row| puts row[:date]}



# # CSV.open("data.csv", "w") do |csv|
# #     csv << ['date', 'total_calories']
# #     csv << [`Nov 14th`, `200`]
# #     csv << [`Nov 16th`, `210`]
# #     csv << [`Nov 19th`, `400`]
# # end