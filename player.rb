# The Player class/object will need instance variables for:
    # 1. player name (Player 1 or Player 2)
    # 2. number of lives
# Player class/object will need getter/setters for lives and name


class Player
    attr_accessor :lives, :name
    
    def initialize(name)
        @name = name
        @lives = 3
    end
end