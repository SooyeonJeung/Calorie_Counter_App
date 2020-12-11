require "tty-prompt"
require "csv"

puts "\nWelcome to CalorieCounter!"
puts "Your friendly weight management assistant to track your calorie intake\n"
# Show the available Menu Options that user can select
puts "Please select from the following options :"
puts "1. Add new calorie intake"
puts "2. View total calorie intake daily"
puts "3. View total calorie intake this week"
puts "4. Exit"

input = gets.chomp.to_i


case input.to_i
when 1
    class AddCalories
        attr_accessor :date, :food_item, :portion
        def initialize(date, food_item, portion)
            @date = date
            @food_item = food_item
            @portion = portion
        end
        
        while_add_intake_start = true
        while while_add_intake_start == true
            puts "You've selected to add new calorie intake"
            # puts "Enter the date (Sun - Sat)"
            prompt = TTY::Prompt.new
            @date = prompt.select("Enter the date (Sun - Sat)", %w(Sun Mon Tue Wed Thu Fri Sat))

            # dates = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            # valid = Validators.validate_amount_against_balance(amount, baßlance)
            # if !valid
            # puts "Your withdrawl is greater than your balance"

            puts "You've entered #{@date}"

            # Display all food items?
            puts "Select food items you've consumed"

            @food_item = gets.chomp

            food_calories_hash = {"Soy milk" => 131, "Quinoa" => 222, "Avocado" => 240, "Dates" => 207, "Buddha Bowl" => 492}
            food_calories_hash.keys.include?(@food_item)

            food_calories = food_calories_hash[:@food_item]
            
            # puts "Select the portion you've consumed (0.5 1 1.5 2)"
            prompt = TTY::Prompt.new
            @portion = prompt.select("Select the portion you've consumed ", %w(0.5 1 1.5 2))

            total_calories = @portion * food_calories.to_f

            user_record = {}
            user_record[:@date] = total_calories
            CSV.open("user_data.csv", "wb") do |csv|
                csv << user_record
            end

            # File.write('user_data.txt', user_record.to_s)

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
    end
    
when 2
    puts "hello"

when 3
    puts "hello"
when 4
    # exit the program
    puts "goodbye"
    exit(0)
end 

