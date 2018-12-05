require 'pry'
require './player'
require './game'

players = [
    Player.new("Player 1"),
    Player.new("Player 2")
]

game = Game.new(players)

game.play_game

binding.pry