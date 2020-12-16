require "tty-prompt"
require "CSV"

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

class AddCalories
    attr_accessor :date, :food_item, :portion
    attr_reader :calorie
    def initialize
        @date = ''
        @food_item = ''
        @portion = 0.0
        @calorie = 0
        @prompt = TTY::Prompt.new
    end

    def find_food_item
        food_item_live = true
        while food_item_live == true
            table = CSV.read("food_calorie_file.csv", headers: true, header_converters: :symbol)
            @portion = @prompt.select("Select food items you've consumed", %w(table[:food_item]))
            
            valid = table[:food_item].include?(@food_item)
                if valid == true
                    food_item_live = false
                else
                    puts "Unable to find the food item. Please select again"
                    food_item_live = false
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
                prompt = TTY::Prompt.new
                @date = prompt.select("Enter the date (Sun - Sat)", %w(Sun Mon Tue Wed Thu Fri Sat))
                puts "You've entered #{@date}"
                
                find_food_item()

                prompt = TTY::Prompt.new
                @portion = prompt.select("Select the portion you've consumed ", %w(0.5 1 1.5 2))

                table = CSV.read("food_calorie_file.csv", headers: true, header_converters: :symbol)
                @calories = table[:@food_item] 
                total_calories = @portion * @calories

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
            table = CSV.read("data.csv", headers: true, header_converters: :symbol)

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
add_calories.handle_input