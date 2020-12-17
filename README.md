# Calorie Counter Application
## R1. Answers to all the documentation requirements below.	
> Completed

## R2. Created a separate heading for each documentation requirement and organized answers accordingly.	
> Completed 

## R3. Referenced sources
### Using CSV files
https://ruby-doc.org/stdlib-2.6.3/libdoc/csv/rdoc/CSV/Row.html
https://ruby-doc.org/stdlib-2.6.1/libdoc/csv/rdoc/CSV.html
https://docs.ruby-lang.org/en/2.0.0/CSV.html
https://stackoverflow.com/questions/12407035/ruby-csv-get-current-line-row-number/12408934
https://www.sitepoint.com/guide-ruby-csv-library-part/

<br />

## R4. Source control repository link
https://github.com/SooyeonJeung/Calorie_Counter_App

<br />

## R5. Statement of Purpose & Scope
### The Application
The calorie counter app counts and tracks calories consumed and produce daily and weekly view of the user's progress over a selected period. The app offers easy usage and accurate tracking to the users without any prior major system setup. This app runs from the terminal.

### The Problem
For anyone interested in weight management, it is emotionally stressful to monitor and track personal calorie intake at all times. On top of this, it' tedious and error-prone to manually store and calculate the data. Finally, the data fail to produce something meaningful for the user to clearly understand their progress over time.

### The Solution
The calorie counter app solves this problem. The app is easy to use and navigate by any users. Once the users enter their calorie intakes, they gain full visibility of their calorie tracking and progress over the selected period. The app helps the users' weight management journey and gives them confidence in building the wellness routine.

### The Audience
Target Audience: Anyone interested to easily view and track the calories consumed is the target audience.

### The Usage
To start with, the user is given four(4) main menu, which are:
  1) Add new calorie intake: A user inputs dates, food items, and portions consumed. The user data gets stored and can be displayed when the user wants to view a daily or weekly view.
  2) View daily calorie intake: The user selects to view the total calorie consumption over a day. The app prints a dietary summary and a guideline to help the user understand their consumption. 
  3) View weekly calorie intake: The user selects to view the total calorie consumption over a day. The app prints a dietary summary and a guideline to help the user understand their consumption. 
  4) Exit: Enter to exit from the app.

For menu options 1-3, the user data can also be downloaded as it gets updated every time the system runs.

<br />

## R6. List of features
### **1.Add Calorie Intake**
A user wants to inputs dates, food items, and portions consumed. The user data gets stored, and the user can add another calorie intake. 

### **2. View daily calorie intake and get a daily summary **
A user wants to view the total calorie consumption over a selected day. The app prints a dietary summary and a guideline to help the user understand their total calorie intake per day.   

### **3.View weekly calorie intake and get a weekly summary**
A user wants to view the total calorie consumption over a week. The app prints a dietary summary of the week, and average calorie per meal. Finally, it prints guideline to help the user understand their overall consumption.    


Note: Ensure that your features above allow you to demonstrate your understanding of the following language elements and concepts:
- use of variables and the concept of variable scope
- loops and conditional control structures
- error handling

<br />

## R7. User Experience Details
### Clear Menu Navigation 
The app provides clear instructions on what are the correct format and options available for them to enter. For every calorie intake, a user is asked to provide three inputs: date, food item, and portion. The user will be prompt with the options displayed in color green. The data will be re-printed after the user entry to confirm the data received. 

***(Used tools: TTY-Prmopt(ruby gem), Boolean)***

### Error Handling
The app has error handling functions, which includes error messages to the user. For example, when the user is unable to provide the correct entry, the system will prompt them to re-enter valid data. 

In this application, below measures has been taken to anticipate the errors and minimize the user impact. 
- begin/rerscue
- when/else
- boolean(if/elsif/else)
- data structure (e.g. .to_i/.to_f, value = 0.0, @date = ‘’)
- TTY-Prompt
- Pry
- clear instructions

***(Used tools: TTY-Prompt, Boolean, Pry)***

### Visual Effects
The app starts with a welcome sign with the two gems installed through bundler, Artii and Colorize. Distinction lines are displayed (...) to seperate the contents and make it easier for the user to read through. For all selections, color green is used. For all confirmation/data print, light blue is used. Finally color cyran is used for printing health recommendation to the users.  

***(Used tools: TTY-Prompt, Artii, Colorize)***

<br />

## R8. Control Flow Diagram
![Flow Chart](docs/CalorieTracker.png)

<br />

## R9. Implementation Plan 
**GitHub Repository**: [link here](https://github.com/SooyeonJeung/portfolio/tree/version-a)

**Trello Board**: [link here](https://trello.com/b/52cXJdyU/calorietracker)
![Trello Board](docs/trello_board.png)
![Feature 1](docs/feature1.png)
![Feature 2](docs/feature2.png)
![Feature 3](docs/feature3.png)

## R10. How to install and use 

### To install and run
- `$ gem install bundler`
- `$ bundle install`
- `$ ruby index.rb `

### Dependencies
- Ruby
- rbenv
- Gem install

### System/Hardware requirements

## R11-R12 Presentation attached
> Completed

## R13-R19 Code Requirements 
> Completed