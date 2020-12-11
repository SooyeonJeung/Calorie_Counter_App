require('menu_view.rb')
require('personal_calorie_records.txt')

system("clear")
menu_view = MenuView.new

class MenuViewController
    def initalize(menu_view)
        @menu_view = menu_view
    end

    def add_intake()
        
        File.open('personal_calorie_records.txt', 'w') do |file|
            character.each{ |date, calories| file.write("#{date}: #{calories}\n") }
        end

        

    end

    def view_daily()
        total_calorie_intake_daily = @menu_view.print_daily_records()
        puts "Your daily calorie intake is #{total_calorie_intake_daily}"
    end
        
    def view_weekly()
        total_calorie_intake_weekly = @menu_view.print_weekly_records()
        puts "Your weekly calorie intake is #{total_calorie_intake_weekly}"
    end

    def run
        #welcome loop
        @menu_view.menu_options

        input = gets.chomp
        
        case input.to_i
        when 1
            @menu_view.add_intake()
        when 2
            # make a withdrawl
            view_daily()
        when 3
            # make a deposit
            view_weekly()
        when 4
            # exit the program
            puts "goodbye"
            exit(0)
        end   
        puts run() 
    end
end
