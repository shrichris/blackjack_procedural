# Blackjack Assignment
# Author: S Srinivasan
# Date: 28th February 2015 

def deal_a_card!(deck)
  dealt_card = deck.pop
  dealt_card
end

def calculate_total(cards) 
  card_values = cards.map{|e| e[1] } 
  total = 0
  card_values.each do |value|
    if value == "A" # capture Ace value first
      total += 11
    elsif value.to_i == 0 # for J, Q, K calling "alphabet"_to_i returns 0
      total += 10
    else
      total += value.to_i
    end
  end

  number_of_aces = card_values.select { |card| card == "A" }.count
  while total > 21 && number_of_aces > 0
    total -=  10
    number_of_aces -= 1
  end
  return total
end

def display_cards(person, cards)
  puts "#{person}'s cards are:"
  cards.each do |card|
    puts "#{card[1]} of #{card[0]}" 
  end
end

def win_or_bust?(person, total)
  if total == 21 
    puts "Blackjack! #{person} wins!"
    exit
  elsif total > 21
    puts "#{person} busts"
    exit
  end
end

def determine_winner(player_cards, player_total, dealer_cards, dealer_total)
  display_cards("Player", player_cards)
  puts ""
  display_cards("Dealer", dealer_cards)
  if player_total < dealer_total
    puts "Player Wins!"
  elsif player_total > dealer_total
    puts "Dealer Wins!"
  else 
    puts "Tie!"
  end
end

#Main Gameplay
puts "Welcome to Blackjack!"
system 'clear'

#Setup deck
suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!
player_cards = []
dealer_cards = []

# Inital Deal
player_cards << deal_a_card!(deck)
dealer_cards << deal_a_card!(deck)
player_cards << deal_a_card!(deck)
dealer_cards << deal_a_card!(deck)
player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)

# Show Cards
display_cards("Player", player_cards)
puts "Player's total is #{player_total}"
display_cards("Dealer", dealer_cards)
puts "Dealer's total is #{dealer_total}"

win_or_bust?("Player", player_total)

#Player's moves
while player_total < 21
  begin
    puts "Player, would you like to hit (H) or stay (S)?"
    player_choice = gets.chomp.upcase
  end until /[HS]/.match(player_choice) != nil

  if player_choice == "S"
    break
  end
#Hit
  player_cards << deal_a_card!(deck)
  player_total = calculate_total(player_cards)
  display_cards("Player", player_cards)
  puts "Player's total is #{player_total}"
  win_or_bust?("Player", player_total)
end

# Dealer's moves
win_or_bust?("Dealer", dealer_total)

while dealer_total < 21
  dealer_cards << deal_a_card!(deck)
  dealer_total = calculate_total(dealer_cards)
  display_cards("Dealer", dealer_cards)
  puts "Dealer's total is #{dealer_total}"
  win_or_bust?("Dealer", dealer_total)
end

determine_winner(player_cards, dealer_cards)

exit