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
  return squares
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
  return win_combos
end

def print_grid
  puts
  puts "   1   2   3"
  puts "A  #{@a1} | #{@a2} | #{@a3}" 
  puts "  ---|---|---"
  puts "B  #{@b1} | #{@b2} | #{@b3} "
  puts "  ---|---|---"
  puts "C  #{@c1} | #{@c2} | #{@c3} "
  puts
  game_over?()
end

def valid_move? square_contents
  if square_contents == " "
    true
  else
    false
  end
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
  # get the move count so we can use it later
  move_count = tally_count()

  user_choice_hash.each do |choice, square|
    if user_choice == choice
      if valid_move?(square)
        square.sub!(/[ ]/, "X") 
      end
    end
  end 
  # check to see if it was a valid move
  if move_count == tally_count()
    invalid_move()
  end
  @turn_count += 1
end

def comp_random
  squares().shuffle.each do |square|
    if valid_move?(square)
      square.sub!(/[ ]/, "O")
      break
    end
  end
end

def comp_win
  win_combos().each do |combos|
    # check to see if the computer can win
    if combos[0] == "O" && combos[1] == "O" && combos[2] == " "
      combos[2].sub!(/[ ]/, "O") 
      break
    elsif combos[0] == "O" && combos[2] == "O" && combos[1] == " "
      combos[1].sub!(/[ ]/, "O") 
      break
    elsif combos[1] == "O" && combos[2] == "O" && combos[0] == " "
      combos[0].sub!(/[ ]/, "O") 
      break
    end
  end
end

def comp_block
  win_combos().each do |combos|
    # check to see if the computer can block the player
    if combos[0] == "X" && combos[1] == "X" && combos[2] == " "
      combos[2].sub!(/[ ]/, "O")
      break
    elsif combos[0] == "X" && combos[2] == "X" && combos[1] == " "
      combos[1].sub!(/[ ]/, "O")
      break
    elsif combos[1] == "X" && combos[2] == "X" && combos[0] == " "
      combos[0].sub!(/[ ]/, "O")
      break
    end
  end
end

def comp_move
  # check to see if the computer should start trying
  if @turn_count > 1
    @tc = tally_count()
    comp_win()
    if @tc == tally_count()
      comp_block()
      if @tc == tally_count()
        comp_random()
      end
    end
  else
    comp_random()
  end
end

def play_again?
  puts "Would you like to play again? (y/n)"
  play_again_answer = gets.chomp.downcase
  if play_again_answer == "y" or play_again_answer == "yes"
    game_engine()
  elsif play_again_answer == "n" or play_again_answer == "no"
    puts "Thanks for playing!"
    exit
  else
    puts "Didn't understand that..."
    play_again?()
  end
end

def the_winner_is winner
  if winner == 'player'
    puts "You win!"
  elsif winner == 'computer'
    puts "The computer wins!"
  end 
  play_again?()
end

def winner?
  win_combos().each do |combos|
    if combos[0] == "X" && combos[1] == "X" && combos[2] == "X"
      # player_wins()
      return 1
    elsif combos[0] == "O" && combos[1] == "O" && combos[2] == "O"
      # computer_wins()
      return 2
    end
  end
end

def tally_count
  tally = 0
  squares().each do |s|
    if s == " "
      tally += 0
    else
      tally += 1
    end
  end
  return tally
end

def game_over?
  # Check to see how many squares are filled
  tally_count()
  # see if there is a winner
  if winner?() == 1
    the_winner_is('player')
  elsif winner?() == 2
    the_winner_is('computer')
  elsif tally_count() == 9
    puts "Cats Game!"
    play_again?()
  else
  end
end

def game_engine
  @turn_count = 0
  clear_board()
  while "velociraptor" > "T-Rex"
    print_grid()
    user_move()
    print_grid()
    comp_move()
  end
end

puts"
+---------------------------+
|       JURASSIC PARK       |
|        TIC TAC TOE        |
+---------------------------+"

game_engine()