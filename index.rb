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

    def user_select
        options = {:encoding => 'UTF-8', :skip_blanks => true}
        CSV.foreach("food_calorie_file.csv", options).with_index do |(f,c), i|
            if f == @food_item
                puts "You've eaten #{@food_item} which is #{c}."
                @calorie = c
                user_taken_index = i
            end
        end
    end

    def find_food_item
        food_item_live = true
        while food_item_live == true
            food_list = @food_calorie_table[:food_item]
            @food_item = @prompt.select("Select food items you've consumed is ",(food_list))

            valid = food_list.include?(@food_item) #validate if the user input is in the database
                if valid == true
                    food_item_live = false
                else
                    puts "Unable to find the food item. Please select again"
                end
            user_select()
            
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

                total_calories = @portion.to_f * @calorie.to_i

                CSV.open("user_data.csv", "a+") do |csv|
                    csv << [@date, total_calories]
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
            @date = @prompt.select("Enter the date (Sun - Sat)", %w(Sun Mon Tue Wed Thu Fri Sat))
            puts "You've entered #{@date}"

            options = {:encoding => 'UTF-8', :skip_blanks => true}
            CSV.foreach("user_data.csv", options).with_index do |(d,t), i|
                if d == @date
                    puts "You have entry ##{i} which is #{t} total calories on #{@date}."
                end
            end
                    
        when 3
            puts "You've selected to view total weekly calorie intake"
            options = {:encoding => 'UTF-8', :skip_blanks => true}
            CSV.foreach("user_data.csv", options).with_index do |(d,t), i|
                if i > 0
                    puts "You have entry ##{i} which is #{t} total calories on #{d}."
                end
            end
        when 4
            puts "Goodbye"
            exit(0)
        end
    end
end

add_calories = AddCalories.new()
puts add_calories.handle_input