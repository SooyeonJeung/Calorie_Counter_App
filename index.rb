require "tty-prompt"
require "csv"

def welcome
    puts "\nWelcome to CalorieCounter!"
    puts "Your friendly weight management assistant to track your calorie intake\n"
    # Show the available Menu Options that user can select
    puts "Please select from the following options :"
    puts "1. Add new calorie intake"
    puts "2. View total calorie intake daily"
    puts "3. View total calorie intake this week"
    puts "4. Exit"
end

welcome()

class AddCalories
    attr_accessor :date, :food_item, :portion
    attr_reader :calorie
    def initialize
        @date = ''
        @food_item = ''
        @portion = 0.0
        @calorie = 0
        @prompt = TTY::Prompt.new
        @food_calorie_table = CSV.read("food_calorie_file.csv", headers: true, header_converters: :symbol)
    end

    def find_food_item
        food_item_live = true
        while food_item_live == true
            food_list = @food_calorie_table[:food_item]
            @food_item = @prompt.select("Select food items you've consumed is ",(food_list))
            # csv = CSV.parse(File.read('food_calorie_file.csv'), :headers => true, header_converters: :symbol)
            # puts csv.find {|row| row['food_item'] == '@food_item'}

            food_list.include?(@food_item) #validate if the user input is in the database

            
            options = {:encoding => 'UTF-8', :skip_blanks => true}
            CSV.foreach("food_calorie_file.csv", options).with_index do |(f,c), i|
                if f == @food_item
                    puts "You've eaten #{@food_item} which is #{c}."
                    user_taken_index = i
                end
            end
            
            # csv = CSV.table("food_calorie_file.csv", converters: :all)
            # row_finding = csv.find do |row|
            #     row.field('food_item') == '@food_item'
            # end

            # p row_finding


            # food_calorie_data = Array.new
            # CSV.foreach("food_calorie_file.csv", col_sep: ',', converters: :numeric) do |row|
            #     food_calorie_data << row[1]
            #     puts "You've eaten #{row[0]} food which is #{row[1]} calories"
            # end
            # # user_select_index = 
            # puts food_calorie_data[user_select_index]



            # food_list_str = food_list.each_with_index do |k, v|
            #     food_list.delete(v)
            # end
            # puts food_list_str 

            # calorie_list = @food_calorie_table[:calories]
            # calorie_list_int = calorie_list.map do |k,v|
            #     v.to_i 
            # end 



            # food_item_index = @food_calorie_table[:food_item].index(@food_item)
            valid = @food_calorie_table[:food_item].include?(@food_item)
                if valid == true
                    food_item_live = false
                else
                    puts "Unable to find the food item. Please select again"
                end
        end 
    end

    def handle_input
        input = gets.chomp.to_i

        case input.to_i
        when 1
            while_add_intake_start = true
            while while_add_intake_start == true
                puts "You've selected to add new calorie intake"
                @date = @prompt.select("Enter the date (Sun - Sat)", %w(Sun Mon Tue Wed Thu Fri Sat))
                puts "You've entered #{@date}"
                
                find_food_item()

                @portion = @prompt.select("Select the portion you've consumed ", %w(0.5 1 1.5 2))
               
                # puts calorie_list_int[:food_item]
                # puts @calories = calorie_list_int[:food_item_index]

                puts @calories
                puts @portion

                total_calories = (@portion.to_f) * @calories

                CSV.open("user_data.csv", "a+") do |csv|
                    csv << [@date, total_calories]
                end

                CSV.open("user_data.csv", 'w') do |csv_object|
                    customers.array.each do |row_array|
                      csv_object << row_array
                    end
                  end

                puts "Do you have more to add? (Y/N)"
                answer = gets.chomp

                if answer == 'Y'
                    while_add_intake_start = true   
                else
                    while_add_intake_start = false
                    puts "goodbye"
                    exit(0)
                end
            end
            
        when 2
            puts "You've selected to view total daily calorie intake"
            # table = CSV.read("data.csv", headers: true, header_converters: :symbol)

        when 3
            puts "hello"
        when 4
            # exit the program
            puts "goodbye"
            exit(0)
        end 

    end
    
end

add_calories = AddCalories.new()
puts add_calories.handle_input