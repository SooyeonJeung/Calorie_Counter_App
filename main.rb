require "tty-prompt"
require "CSV"

puts "\nWelcome to CalorieCounter!"
puts "Your friendly weight management assistant to track your calorie intake\n"
# Show the available Menu Options that user can select
puts "Please select from the following options :"
puts "1. Add new calorie intake"
puts "2. View total calorie intake daily"
puts "3. View total calorie intake this week"
puts "4. Exit"



class AddCalories
    def keywords
        attr_accessor :date, :food_item, :portion
        attr_reader :calorie
        def initialize(date:, food_item:, portion:, calorie:)
            
            @date = date
            @food_item = food_item
            @portion = portion
            @calorie = calorie
        end
    end

    input = gets.chomp.to_i

    case input.to_i
    when 1
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
        
            def self.import(path:)
                CSV.read("food_calories_file.csv", headers: true).map do |row|
                Food_item.new(
                    @food_item: row["food_item"],
                    @calorie: row["calorie"].to_i,)
                end 
            end

            food_calories_hash.keys.include?(@food_item)
            food_calories = food_calories_hash[:@food_item]
            
            # puts "Select the portion you've consumed (0.5 1 1.5 2)"
            prompt = TTY::Prompt.new
            @portion = prompt.select("Select the portion you've consumed ", %w(0.5 1 1.5 2))

            total_calories = @portion * food_calories.to_f

            # user_record = {}
            # user_record[:@date] = total_calories
            # def csv_file
            #     CSV.open("user_data.csv", "wb") do |csv|
            #         csv << user_record
            #     end
            # end

            CSV.open("user_data.csv", "wb") do |csv|
            csv << [:@date, total_calories]
            end

            user_data = CSV.generate do |csv|
                # csv << ['foo', 0]
                # csv << ['bar', 1]
                # csv << ['baz', 2]
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
        
    when 2
        puts "You've selected to view total daily calorie intake"

    when 3
        puts "hello"
    when 4
        # exit the program
        puts "goodbye"
        exit(0)
    end 

