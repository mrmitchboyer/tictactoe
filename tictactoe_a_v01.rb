def clear_board
  @a1 = " "
  @a2 = " "
  @a3 = " "
  @b1 = " "
  @b2 = " "
  @b3 = " "
  @c1 = " "
  @c2 = " "
  @c3 = " "
end

def squares
  squares = [@a1, @a2, @a3, @b1, @b2, @b3, @c1, @c2, @c3]
  squares
end

def win_combos
  win_combos = [[@a1, @a2, @a3],
                [@a1, @b2, @c3],
                [@a1, @b1, @c1],
                [@b1, @b2, @b3],
                [@c1, @c2, @c3],
                [@c1, @b2, @a3],
                [@a2, @b2, @c2],
                [@a3, @b3, @c3]]
  win_combos
end

def print_grid
  puts
  puts "   1   2   3"
  puts "A  #{@a1} | #{@a2} | #{@a3} " 
  puts "  ---|---|---"
  puts "B  #{@b1} | #{@b2} | #{@b3} "
  puts "  ---|---|---"
  puts "C  #{@c1} | #{@c2} | #{@c3} "
  puts
  game_over?()
end

def tally_count
  tally = 0
  squares().each do |s|
    if s == " "
    else
      tally += 1
    end
  end
  tally
end

# MOVES

def valid_move? square_contents
  true if square_contents == " "
end

def invalid_move
  puts "Oops! That's not a valid entry."
  user_move()
end

def user_move
  user_choice_hash = {"a1" => @a1,
                      "a2" => @a2,
                      "a3" => @a3,
                      "b1" => @b1,
                      "b2" => @b2,
                      "b3" => @b3,
                      "c1" => @c1,
                      "c2" => @c2,
                      "c3" => @c3}

  puts "Please choose a square:"
  user_choice = gets.chomp.downcase
  move_count = tally_count()
  if user_choice == "q" or user_choice == "quit"
    exit
  end
  user_choice_hash.each do |choice, square|
    if user_choice == choice
      if valid_move?(square)
        square.sub!(/ /, "X") 
      end
    end
  end 
  if move_count == tally_count()
    invalid_move()
  end
  @turn_count += 1
end

def comp_move
  puts "#{@dinosaur} is thinking..."
  sleep(0.5)
  if @turn_count > 1
    move_count = tally_count()
    comp_win()
    if move_count == tally_count()
      comp_block()
      comp_random() if move_count == tally_count()
    end
  else
    comp_random()
  end
end

def comp_random
  squares().shuffle.each do |square|
    if valid_move?(square)
      square.sub!(/ /, "O")
      break
    end
  end
end

def comp_win
  # check to see if the computer can win
  win_combos().each do |combos|
    if combos[0] == "O" && combos[1] == "O" && combos[2] == " "
      combos[2].sub!(/ /, "O") 
      break
    elsif combos[0] == "O" && combos[2] == "O" && combos[1] == " "
      combos[1].sub!(/ /, "O") 
      break
    elsif combos[1] == "O" && combos[2] == "O" && combos[0] == " "
      combos[0].sub!(/ /, "O") 
      break
    end
  end
end

def comp_block
  # check to see if the computer can block the player
  win_combos().each do |combos|
    if combos[0] == "X" && combos[1] == "X" && combos[2] == " "
      combos[2].sub!(/ /, "O")
      break
    elsif combos[0] == "X" && combos[2] == "X" && combos[1] == " "
      combos[1].sub!(/ /, "O")
      break
    elsif combos[1] == "X" && combos[2] == "X" && combos[0] == " "
      combos[0].sub!(/ /, "O")
      break
    end
  end
end

# END OF GAME

def game_over?
  the_winner_is('player') if winner?() == 1
  the_winner_is('computer') if winner?() == 2
  the_winner_is('cats game') if tally_count() == 9
end

def winner?
  win_combos().each do |combos|
    if combos[0] == "X" && combos[1] == "X" && combos[2] == "X"
      # player wins 
      return 1
    elsif combos[0] == "O" && combos[1] == "O" && combos[2] == "O"
      # computer wins 
      return 2
    end
  end
end

def end_message hash
  hash.each do |dino, message|
    if dino.upcase == @dinosaur
      message_shuffle = message.sample
      return message_shuffle
    end
  end
end

def the_winner_is winner
  dino_death_hash = {"Tyrannosaurus" => ["#{@dinosaur} ate you while you were hiding on the john!", 
                                         "You fell off a cliff while #{@dinosaur} was chasing you!"],
                     "Dilophosaurus" => ["#{@dinosaur} spit on you!", 
                                         "#{@dinosaur} ate you while you were looking for the boat."],
                     "Velociraptor" =>  ["#{@dinosaur} attacked from the side. Clever girl!", 
                                         "#{@dinosaur} killed you while you were trying to turn the power back on."]}

  dino_kill_hash = {"Tyrannosaurus" => ["You shot #{@dinosaur} with a high-powered rifle!", 
                                        "#{@dinosaur} fell off a cliff while chasing you!"],
                    "Dilophosaurus" => ["#{@dinosaur} tried to spit on you, but you shot him with a tranquilizer!", 
                                        "You ran over #{@dinosaur} in your Jeep!"],
                    "Velociraptor" =>  ["You shot #{@dinosaur} before she could get you!", 
                                        "You blew up #{@dinosaur} with a grenade!"]}

  cats_game_hash = {"Tyrannosaurus" => ["You outran #{@dinosaur} in a Jeep.", 
                                        "You lost #{@dinosaur} by going under an electric fence."],
                    "Dilophosaurus" => ["#{@dinosaur} tried to spit on you, but you dodged the spit!", 
                                        "You've escaped #{@dinosaur} in your Jeep!"],
                    "Velociraptor" =>  ["Somehow you've lost #{@dinosaur}.", 
                                        "The #{@dinosaur} has disappeared!"]}
  if winner == 'player'
    puts end_message(dino_kill_hash)
    puts "(You win!)"
  elsif winner == 'computer'
    puts end_message(dino_death_hash)
    puts "Better luck next time. (You lose)"
  elsif winner == 'cats game'
    puts end_message(cats_game_hash)
    puts "You're safe for now... (Cats game)"
  end 
  puts
  play_again?()
end

def play_again?
  puts "Would you like to play again? (y/n)"
  play_again_answer = gets.chomp.downcase
  if play_again_answer == "y" or play_again_answer == "yes"
    puts
    game_engine()
  elsif play_again_answer == "n" or play_again_answer == "no"
    puts "Thanks for playing!"
    puts
    exit
  elsif play_again_answer == "q" or play_again_answer == "quit"
  else
    puts "Didn't understand that..."
    play_again?()
  end
end

# START OF GAME

def game_start
  puts "Welcome to..."
  puts
  puts "+---------------------------+"
  puts "|       JURASSIC PARK       |"
  puts "|        TIC TAC TOE        |"
  puts "+---------------------------+"
  puts "[imagine awesome theme music here]"
  puts '[press "q" at anytime to exit]'
  puts
end

def choose_character
  character_quotes_hash = {'Dr. Ellie Sattler' => ["Dinosaurs eat man ... woman inherits the earth.",
                                                   "Well, the question is, how can you know anything about \n an extinct ecosystem? And therefore, how could you ever \n assume that you can control it?"],
                           'Dennis Nedry'      => ["Do you know anyone who can network eight connection machines \n and debug 2 million lines of code for what I bid for this job? \n Because if he can I'd like to see him try.",
                                                   "Dodgson, Dodgson, we have Dodgson here! See? Nobody cares.",
                                                   "Uh uh uh! You didn't say the magic word!"],
                           'Dr. Ian Malcom'    => ["But again, how do you know they're all female? Does someone \n go into the park and, uh ... pull up the dinosaurs' skirts?",
                                                   "God creates dinosaurs. God destroys dinosaurs. God creates man. \n Man destroys God. Man creates dinosaurs.",
                                                   "Yeah, but John, if the Pirates of the Caribbean breaks down, \n the pirates don't eat the tourists.",
                                                   "Life, uh ... finds a way."]}

  puts "Choose your character: (1-3)"
  puts "(1) Dr. Ellie Sattler"
  puts "(2) Dennis Nedry"
  puts "(3) Dr. Ian Malcolm"
  character_choice = gets.chomp
  puts
  if character_choice == "1" or character_choice == "2" or character_choice == "3"
  # option to quit
  elsif character_choice == "q" or character_choice == "quit"
    exit
  else
    puts "Oops! Looks like that's not an option."
    puts
    choose_character()
  end

  @character = "Dr. Ellie Sattler" if character_choice == "1"
  @character = "Dennis Nedry" if character_choice == "2"
  @character = "Dr. Ian Malcom" if character_choice == "3"

  character_quotes_hash.each do |c, quote|
    if c == @character
      quote_shuffle = quote.sample
      puts "You selected #{@character.upcase}"
      puts "\"#{quote_shuffle}\""
    end
  end
end

def dino_opponent
  dino = ["Tyrannosaurus", "Dilophosaurus", "Velociraptor"]
  @dinosaur = dino.sample.upcase
  puts
  puts "You are playing against #{@dinosaur}. Good luck!"
end

def game_engine
  @turn_count = 0
  clear_board()
  choose_character()
  dino_opponent()
  while "velociraptor" > "T-Rex"
    print_grid()
    user_move()
    print_grid()
    comp_move()
  end
end

# RUN THE PROGRAM

game_start()
game_engine()