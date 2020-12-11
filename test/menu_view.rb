require_relative('Calorie_Counter_App/personal_calorie_records.txt')

# The view for Menu Options 
class MenuView
    def menu_options
        puts "\nWelcome to CalorieCounter"
        puts "Your friendly weight management assistant to track your calorie intake\n"
        # Show the available Menu Options that user can select
        puts "Please select from the following options :"
        puts "1. Add new calorie intake"
        puts "2. View total calorie intake daily"
        puts "3. View total calorie intake this week"
        puts "4. Exit"
    end

    def bring_up_records_daily
        # extract just the value and pull it out by dates
        hash.each do |date, calories|
            File.open('personal_calorie_records.txt', 'w') { |file| file.puts *calories }
          end
    end

    def print_daily_records 
        total_calorie_intake_daily = bring_up_records_daily()
    end

    def bring_up_records_weekly
        # extract just the value and make a sun of all values
        hash.each do |date, calories|
            File.open('personal_calorie_records.txt', 'w') { |file| file.puts *calories }
        end  
    end

    def print_weekly_records
        total_calorie_intake_weekly = bring_up_records_weekly()
    end

    
end
