# Basic Objectives:
# - User inputs question
# - Computer outputs random answer
# - User inputs "QUIT"
# - Computer outputs a goodbye message and exits

# Bonus Objectives:
# - ability to add more answers:
# - via easter egg question ("add_answers")
# - do not let them add the same answer if the eight ball already has that answer

# - ability to reset answers back to original bank (hint: think arr.clone)
# - via easter egg question ("reset_answers")

# - ability to have eight ball print all answers
# - via easter egg question ("print_answers")

@history = []

def main_menu()
	puts "\n~~~ MAGIC 8 BALL ~~~"
	puts "Main Menu:"
	puts "1. Get Started"
	puts "2. View History"
	puts "3. Exit"
	print "Enter Selection: "
	case gets.strip.downcase
	when "1", "start", "get started"
		answer_questions()
	when "2", "history", "view history"
		view_history()
	when "3", "exit"
		puts "\nThanks for using MAGIC 8 BALL!\n\n"
		exit
	else
		puts "\nInvalid Input! Unacceptable!"
		main_menu()
	end
end

def answer_questions()
	@possible_answers[:working] << @possible_answers[:default]
	@possible_answers[:working].flatten!.uniq!
	puts "\nAsk me any question... or type 'done' to return to the main menu."
	user_question = gets.strip.downcase
	case user_question
	when "done"
		puts "\nI didn't want to answer your questions anyway!\n"
	when "i don't like that answer.", "add_answers"
		custom_answers()
		answer_questions()
	when "reset_answers"
		@possible_answers[:working] = []
		puts "\nCustom answers cleared!"
	when "print_answers"
		print_answers()
	else
		if user_question.include? "?"
			if @possible_answers.has_key? user_question
				answer = "\n~ Magic 8 Ball says: #{@possible_answers[user_question]}\n"
				puts answer
				combined_answer = "#{user_question} #{answer}"
				@history << combined_answer
			else
				answer = "\n~ Magic 8 Ball says: #{@possible_answers[:working].sample}\n"
				puts answer
				combined_answer = "#{user_question} #{answer}"
				@history << combined_answer
			end
			answer_questions()
		else
			puts "\nThat's not a question! Where's your question mark?"
			answer_questions()
		end
	end
end

 @possible_answers = {
	"what is the meaning of life?" => "42",
	"do you love me?" => "I'm Old Greeeeeegg!",
	default: [
		"Totally!",
		"No chance!",
		"Go for it!",
		"Maybe!",
		"Most likely.",
		"My sources say no.",
		"Signs point to yes.",
		"Very doubtful."
		],
	working: []
}

def print_answers ()
	puts "\nCurrent answers:"
	puts @possible_answers[:working]
	puts
end

def custom_answers()
	puts "\nFine! Make your own."
	puts "\nCurrent answers:"
	puts @possible_answers[:working]
	print "\nEnter your own answer: "
	new_answer = gets.strip
	if new_answer.downcase == "reset_answers"
		@possible_answers[:working] = []
		puts "\nCustom answers cleared!"
	else
		@possible_answers[:working] << new_answer
		puts "#{new_answer} has been added!"
	end
end

def view_history()
	@history.each do |item|
		puts
		puts item
		puts
	end
end

while true
	main_menu()
end