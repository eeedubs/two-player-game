# The Game class/object will need methods for:
    # 1. simulating questions
    # 2. taking answers
    # 3. guessing correctly
    # 4. guessing incorrectly
    # 5. outputing "new turn"
    # 6. who the current player is
    # 7. game over
# Instance variables include:
    # players in game
    # current user
    # starting user (shouldn't always be player 1... unfair advantage for player 2)
# Local variables include: 
    # for play_game:
        # 2 random numbers from 1-20 (for play_game)
        # the sum of those two random numbers
        # the user's guess
        # the true/false boolean of the user's guess relative to the correct sum
    # for play_again
        # answer to yes/no to the question of "play again?"
# Game class/object will need getter/setter for current_user

class Game
    attr_accessor :current_user

    ## Called when Game.new(players) is assigned to a variable (creates the game)
    ## assigns the starting user to a random player, either p1 or p2
    ## outputs the starting message
    def initialize(playersArray)
        @players = playersArray
        start_user = rand(0..1)
        @current_user = @players[start_user]
        puts "\nWelcome to Add Off!\n-------------------"
    end

    @@new_turn_alert = "----- NEW TURN -----"
    @@game_over_alert = "----- GAME OVER -----"

    ## Asks the questions
    ## Takes x and y as random integers between 1 and 20, and records the sum of those two numbers
    ## Asks the user for their guess, and records that guess
    ## Records the true or false value of the answer
    ## Passes the true/false value to the handle_guess(input) method
    def play_game
        x = rand(1..20)
        y = rand(1..20)
        sum = x + y
        puts "#{current_user.name}: What is #{x} + #{y}?"
        guess = gets.chomp.to_i
        trueOrFalse = (sum == guess)
        handle_guess(trueOrFalse)
    end

    # If the input is false, alert failure and invoke the lose_life(user) method
    # Else if the input is true, alert success, switch users, alert with a new round variable, and play the game again
    def handle_guess(input)
        if input == false
            puts "#{@current_user.name}: Seriously? No!"
            lose_life(@current_user)
        elsif input == true
            puts "#{@current_user.name}: YES! You are correct."
            puts "P1: #{@players[0].lives}/3 vs P2: #{@players[1].lives}/3"
            switch_user
            puts "\n" + @@new_turn_alert
            play_game
        else
            puts "Unhandled error"
        end
    end

    # handles the switching of users
    def switch_user
        if @current_user == @players[0]
            @current_user = @players[1]
        elsif @current_user == @players[1]
            @current_user = @players[0]
        end
    end

        # If the user has more than 1 life, switch current user, alert the score, alert the new round, play the game
    # Else if the user has only 1 life, switch current user (to alert the winner and not the loser), alert the end of 
    # the game, say good bye
    def lose_life(user)
        if user.lives > 1
            user.lives -= 1
            switch_user
            puts "P1: #{@players[0].lives}/3 vs P2: #{@players[1].lives}/3"
            puts "\n" + @@new_turn_alert
            play_game
        elsif user.lives == 1
            switch_user
            puts "#{@current_user.name} wins with a score of #{@current_user.lives}/3"
            puts "\n" + @@game_over_alert
            play_again?
        end
    end

    ## Invoked once the game ends
    ## Asks the user if they would like to play again
    ## if yes, assign new players (with 3 lives) and run the game again with the new players
    ## if no, say goodbye with an empty line
    ## else (if the input isn't yes or no), repeat the play_again? method
    def play_again?
        puts "Would you like to play again? Type 'yes' or 'no':"
        answer = gets.chomp
        if answer == "yes"
            puts "\n\n\n"
            new_players = [
                player1 = Player.new("Player 1"),
                player2 = Player.new("Player 2")
            ]
            game = Game.new(new_players)
            game.play_game
        elsif answer =="no"
            puts "Good Bye!"
            puts
        else
            play_again?
        end
    end
end