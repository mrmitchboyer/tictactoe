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
    return true
  else
    return false
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
end

def comp_move
  r = rand(8)
  if r == 0
    if valid_move?(@a1)
      @a1 = "O"
    else
      comp_move() 
    end
  elsif r == 1
    if valid_move?(@a2)
      @a2 = "O"
    else
      comp_move() 
    end
  elsif r == 2
    if valid_move?(@a3)
      @a3 = "O"
    else
      comp_move() 
    end
  elsif r == 3
    if valid_move?(@b1)
      @b1 = "O"
    else
      comp_move() 
    end
  elsif r == 4
    if valid_move?(@b2)
      @b2 = "O"
    else
      comp_move() 
    end
  elsif r == 5
    if valid_move?(@b3)
      @b3 = "O"
    else
      comp_move() 
    end
  elsif r == 6
    if valid_move?(@c1)
      @c1 = "O"
    else
      comp_move() 
    end
  elsif r == 7
    if valid_move?(@c2)
      @c2 = "O"
    else
      comp_move() 
    end
  elsif r == 8
    if valid_move?(@c3)
      @c3 = "O"
    else
      comp_move() 
    end
  else
    comp_move()
  end
end

def player_wins
  puts "You win!"
end

def computer_wins
  puts "The computer wins!"
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

def game_over?
  # Check to see how many squared are filled
  @tally = 0
  squares = [@a1, @a2, @a3, @b1, @b2, @b3, @c1, @c2, @c3]
  squares.each do |s|
    if s == " "
      @tally += 0
    else
      @tally += 1
    end
  end

  # see if there is a winner
  if winner?() == 1
    player_wins()
    exit
  elsif winner?() == 2
    computer_wins()
    exit
  elsif @tally == 9
    puts "Cats Game!"
    exit
  else
  end
end



def game_engine
  while "velociraptor" > "T-Rex"
    user_move()
    print_grid()
    comp_move()
    print_grid()
  end
end

puts"
+---------------------------+
|       JURASSIC PARK       |
|        TIC TAC TOE        |
+---------------------------+"

print_grid()
game_engine()