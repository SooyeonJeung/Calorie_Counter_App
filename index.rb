require "tty-prompt"
require "csv"
require 'pry'
require 'colorize'
require 'artii'

def art(x)
    a = Artii::Base.new :font => 'big'
    puts a.asciify(x).colorize(:red)
end
art("CalorieCounter")

def welcome
    puts "\nWelcome to CalorieCounter!"
    puts "Your friendly weight management assistant to track your calorie intake\n"
    puts "..............................................................................................".colorize(:red)
    # Show the available Menu Options that user can select
    puts "We have the following options for you (Enter 1 - 4) :"
    puts "1. Add new calorie intake"
    puts "2. View total calorie intake daily"
    puts "3. View total calorie intake this week"
    puts "4. Exit"
    puts "..............................................................................................".colorize(:red)
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

        #Error handling: If the `food_calorie_file.csv` cannot be located, 
        #1)print a error message to the user, 2)create a new file with the data, and 3)ensure the user have no issues navigating the app. 
        begin 
            @food_calorie_table = CSV.read("food_calorie_file.csv", headers: true, header_converters: :symbol)
        rescue 
            puts "Alert: Couldn't open the food calorie file, so a new food calorie file has been created for you."
            puts "Select the above menu option you want to access (1-4)."
            system('touch food_calorie_file.csv')
            CSV.open("food_calorie_file.csv", "a+") do |csv|
                csv << [:food_item, :calories]
                csv << ['Soy milk with muesli', '236']
                csv << ['Quinoa salad', '222']
                csv << ['Lentil dal curry', '122']
                csv << ['Avocado toast', '157']
                csv << ['Dates', '207']
                csv << ['Buddha Bowl', '492']
                csv << ['Peanut butter toast', '205']
                csv << ['Roasted Potatoes and veggies', '300']
                csv << ['Nuts mix', '200']
                csv << ['Vegan Pesto Pasta', '200']
                csv << ['Kale Salad', '50']
                csv << ['Fruit mix', '60']
                csv << ['Oat flat white', '127']
            end
            @food_calorie_table = CSV.read("food_calorie_file.csv", headers: true, header_converters: :symbol)
        end
    end

    def user_select
        options = {:encoding => 'UTF-8', :skip_blanks => true}
        CSV.foreach("food_calorie_file.csv", options).with_index do |(f,c), i|
            if f == @food_item
                puts "You've eaten #{@food_item} which is #{c}.".colorize(:light_blue)
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
            food_item_live = false
            user_select()
        end 
    end

    def handle_input
        input = gets.chomp.to_i
        case input.to_i
        when 1
            while_add_intake_start = true
            while while_add_intake_start == true
                puts "You've selected to add new calorie intake."
                @date = @prompt.select("Enter the date (Sun - Sat).", %w(Sun Mon Tue Wed Thu Fri Sat))
                puts "You've entered #{@date}.".colorize(:light_blue)
                
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
                    puts "Goodbye"
                    exit(0)
                end
            end
            
        when 2
            puts "You've selected to view total daily calorie intake."
            @date = @prompt.select("Enter the date (Sun - Sat)", %w(Sun Mon Tue Wed Thu Fri Sat))
            puts "You've entered #{@date}".colorize(:light_blue)

            options = {:encoding => 'UTF-8', :skip_blanks => true}
            daily_total_calorie = 0.0
            CSV.foreach("user_data.csv", options).with_index do |(d,t), i|
                if d == @date
                    t = t.to_i
                    daily_total_calorie += t
                end
            end
            puts "You had #{daily_total_calorie} total calories on #{@date}.".colorize(:light_blue)
            if daily_total_calorie > 2000
            puts "You have taken over the range of the recommended calorie guideline.".colorize(:magenta)
            elsif daily_total_calorie <= 2000 && daily_total_calorie >= 1600
                puts "Your calorie intake is within the range of the recommended calorie guideline.".colorize(:magenta)
            elsif daily_total_calorie < 1600 && daily_total_calorie >= 1300
                puts "You have taken below the range of the recommended calorie guideline.".colorize(:magenta)
            else 
                puts "The number of data is too small to give you a holistic recommendation for this date.".colorize(:magenta)
            end 

            puts "Do you have any new food intake to add? (Y/N)"
            redirect_to_menu_one = gets.chomp

            if redirect_to_menu_one == 'Y'
                puts "Enter 1 to add new calorie intake or enter return to exit"
                AddCalories.new().handle_input
            else
                puts "Goodbye"
                exit(0)
            end
            
                    
        when 3
            puts "You've selected to view total weekly calorie intake."

            options = {:encoding => 'UTF-8', :skip_blanks => true}
            weekly_total_calorie = 0.0
            week_array =[]
            CSV.foreach("user_data.csv", options).with_index do |(d,t), i|
                t = t.to_i
                weekly_total_calorie += t
                week_array << d
            end
            week_array.shift()
            week_array = week_array.uniq.count

            avg_cal = weekly_total_calorie / week_array
            puts "You had #{weekly_total_calorie} which is a sum of #{week_array} entries.(avg of #{avg_cal}/meal)".colorize(:light_blue)
            
            if avg_cal > 400 && avg_cal < 1000
                puts "You have eaten more calories than recommended.".colorize(:magenta)
            elsif avg_cal <= 400 && avg_cal >= 200
                puts "You have eaten a recommended amount. Well done!".colorize(:magenta) 
            elsif avg_cal < 200
                puts "You have eaten less calories than recommended.".colorize(:magenta)
            elsif avg_cal >= 1000
                puts "The average is abnormally high. You'd better check the accuracy of the log!".colorize(:magenta)
            else
                puts "Data entry Error: Start over again!".colorize(:magenta)
            end

            puts "Do you have any new food intake to add? (Y/N)"
            redirect_to_menu_one = gets.chomp

            if redirect_to_menu_one == 'Y'
                puts "Enter 1 to add new calorie intake or enter return to exit."
                AddCalories.new().handle_input
            else
                puts "Goodbye"
                exit(0)
            end

        when 4
            puts "Goodbye"
            exit(0)
        else #Error handling: If the user input is wrong, print a helpful message so that the user can enter valid entry.
            puts "Invalid entry: Please input one of the numeric option between 1-4.".colorize(:red)
            AddCalories.new().handle_input
        end
    end
end

add_calories = AddCalories.new()
puts add_calories.handle_input