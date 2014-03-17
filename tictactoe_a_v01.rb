def clear_board
  # set all of the squares to " "
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
  puts "Please choose a square:"
  user_choice = gets.chomp.downcase

  if user_choice == "a1"
    if valid_move?(@a1)
      @a1 = "X"
    else
      invalid_move() 
    end
  elsif user_choice == "a2"
    if valid_move?(@a2)
      @a2 = "X"
    else
      invalid_move() 
    end
  elsif user_choice == "a3"
    if valid_move?(@a3)
      @a3 = "X"
    else
      invalid_move() 
    end
  elsif user_choice == "b1"
    if valid_move?(@b1)
    @b1 = "X"
    else
      invalid_move() 
    end
  elsif user_choice == "b2"
    if valid_move?(@b2)
    @b2 = "X"
    else
      invalid_move() 
    end
  elsif user_choice == "b3"
    if valid_move?(@b3)
    @b3 = "X"
    else
      invalid_move() 
    end
  elsif user_choice == "c1"
    if valid_move?(@c1)
    @c1 = "X"
    else
      invalid_move() 
    end
  elsif user_choice == "c2"
    if valid_move?(@c2)
    @c2 = "X"
    else
      invalid_move() 
    end
  elsif user_choice == "c3"
    if valid_move?(@c3)
    @c3 = "X"
    else
      invalid_move() 
    end
  else
    invalid_move() 
  end
  @turn_count += 1
end

# COMPUTER MOVE

def random_square
  squares = [@a1, @a2, @a3, @b1, @b2, @b3, @c1, @c2, @c3]
  squares.shuffle.each do |square|
    if valid_move?(square)
      square.sub!(/[ ]/, "O")
      break
    end
  end
end

def comp_win
  win_combos = [[@a1, @a2, @a3],
                [@a1, @b2, @c3],
                [@a1, @b1, @c1],
                [@b1, @b2, @b3],
                [@c1, @c2, @c3],
                [@c1, @b2, @a3],
                [@a2, @b2, @c2],
                [@a3, @b3, @c3]]

  win_combos.each do |combos|
    # check to see if you can win
    if combos[0] == "O" && combos[1] == "O" && combos[2] != "X"
      combos[2].sub!(/[ ]/, "O") 
      break
    elsif combos[0] == "O" && combos[2] == "O" && combos[1] != "X"
      combos[1].sub!(/[ ]/, "O") 
      break
    elsif combos[1] == "O" && combos[2] == "O" && combos[0] != "X"
      combos[0].sub!(/[ ]/, "O") 
      break
    end
  end
end

def comp_block
  win_combos = [[@a1, @a2, @a3],
                [@a1, @b2, @c3],
                [@a1, @b1, @c1],
                [@b1, @b2, @b3],
                [@c1, @c2, @c3],
                [@c1, @b2, @a3],
                [@a2, @b2, @c2],
                [@a3, @b3, @c3]]
                
  win_combos.each do |combos|
    # check to see if you can win
    if combos[0] == "X" && combos[1] == "X" && combos[2] != "O"
      combos[2].sub!(/[ ]/, "O")
      break
    elsif combos[0] == "X" && combos[2] == "X" && combos[1] != "O"
      combos[1].sub!(/[ ]/, "O")
      break
    elsif combos[1] == "X" && combos[2] == "X" && combos[0] != "O"
      combos[0].sub!(/[ ]/, "O")
      break
    end
  end
end


def comp_move
  # check to see if it should start trying
  if @turn_count > 1
    tally_count()
    @tc = @tally
    comp_win()
    tally_count()
    if @tc == @tally
      comp_block()
      tally_count()
      if @tc == @tally
        random_square()
      end
    end
  else
    random_square()
  end
end

# END COMPUTER MOVE

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
  win_combos = [[@a1, @a2, @a3],
                [@a1, @b2, @c3],
                [@a1, @b1, @c1],
                [@b1, @b2, @b3],
                [@c1, @c2, @c3],
                [@c1, @b2, @a3],
                [@a2, @b2, @c2],
                [@a3, @b3, @c3]]

  win_combos.each do |combos|
    if combos[0] == "X" && combos[1] == "X" && combos[2] == "X"
      # player_wins()
      return 1
    elsif combos[0] == "O" && combos[1] == "O" && combos[2] == "O"
      # computer_wins()
      return 2
    else
    end
  end
end

def tally_count
  # Check to see how many squares are filled
  @tally = 0
  squares = [@a1, @a2, @a3, @b1, @b2, @b3, @c1, @c2, @c3]
  squares.each do |s|
    if s == " "
      @tally += 0
    else
      @tally += 1
    end
  end
end

def game_over?
  tally_count()
  # see if there is a winner
  if winner?() == 1
    the_winner_is('player')
  elsif winner?() == 2
    the_winner_is('computer')
  elsif @tally == 9
    puts "Cats Game!"
    play_again?()
  else
  end
  @tally
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