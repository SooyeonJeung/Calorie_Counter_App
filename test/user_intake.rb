class AddCalories 
    attr_accessor :date, :food_item, :portion

    def initialize(date, food_item, portion)
        @date = date
        @food_item = food_item
        @portion = portion
    end

    def user_intake()
        loop do
            puts "Please enter the date (Sun - Sat)"
            @date = gets.chomp
            puts "You've entered #{@date}"
            # Display all food items?
            puts "Select food items you've consumed"
            @food_item = gets.chomp
            puts "Select the portion you've consumed (0.5 / 1 / 1.5 / 2)"
            @portion= gets.chomp.to_f

            def finish_food_intake()
                puts "Do you have more to add? (Y/N)"
                if N
                    break 
                else
                    puts "You've entered wrong"
                    finish_food_intake()
                end
            end
        end
    
    end

    def user_record()
        calories = @food_item.to_i * @portion.to_i
        File.write('personal_calorie_records.txt', |@date, calories|)
    end
    

end
