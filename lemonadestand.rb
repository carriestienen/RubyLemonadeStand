#starting money, picthers and cups
munny=100
cupsInPitcher=0
cupsPerPitcher=12
#number of cups in a pitcher
cupsInPitcher=12
#weather possibilities array
weather = ["hot", "good", "average", "bad"]
#how many cups will be sold depending on the weather
weatherCups = [75,50,30,20]

#you start with none of each ingredient
lemon=0
sugar=0
cups=0
ice=0

#amount that comes with cost
lemonPurchase=75
sugarPurchase=50
cupsPurchase=100
icePurchase=500

#cost of ingredients
lemonCost=4
sugarCost=3
cupsCost=1
iceCost=4

def makePitcher
  if (lemon >= 4 && sugar >= 4 && currentCups == 0)
    sugar -= 4
    lemon -= 4
    cupsInPitcher += cupsPerPitcher
    return true
  else
    return false
  end
end

def makeCup
  if (cupsInPitcher > 0 && ice >= 4 && cups >= 1)
    ice -= 4
    cups -= 1
    cupsInPitcher -= 1
    return true
  else
    return false
  end
end

index=0

while index < 30
  temp = rand(4)
  w = weather[temp]
  cupsCanSell = weatherCups[temp]

  response = nil
  #prompt for ingredients purchases
  while response != 'q'
    puts "Good morning, it is day #{index} and the weather today is #{w}. \nYou have:"
    puts "#{lemon} lemons\n#{sugar} cups of sugar\n#{cups} paper cups \nand #{ice} ice cubes."
    puts "Type a letter to let us know what you want to do."
    puts "l=buy #{lemonPurchase} lemons for #{lemonCost} munny."
    puts "s=buy #{sugarPurchase} cups of sugar for #{sugarCost} munny."
    puts "i=buy #{icePurchase} ice cubes for #{iceCost} munny."
    puts "p=buy #{cupsPurchase} paper cups for #{cupsCost} munny."
    puts "q=done buying ingredients"
    puts "You have #{munny} munny."
    print "> "

    response = gets.chomp
    
    if response == 'l'
      munny -= lemonCost
      lemon += lemonPurchase
    elsif response == 's'
      munny -= sugarCost
      sugar += sugarPurchase
    elsif response == 'i'
      munny -= iceCost
      ice += icePurchase
    elsif response == 'p'
      munny -= cupsCost
      cups += cupsPurchase
    end
  end

  #figure out how many pitchers and cups we can make
  if sugar < lemon
    pitchersCanMake = (sugar/4).floor
  else
    pitchersCanMake = (lemon/4).floor
  end

  if pitchersCanMake*12 <= cups && pitchersCanMake*12 <= ice/4
    cupsCanMake = pitchersCanMake*12
  elsif cups <= ice/4
    cupsCanMake = cups
  else
    cupsCanMake = ice/4
  end

  #figure out how many cups we will sell
  if cupsCanSell < cupsCanMake
    cupsSold = cupsCanSell
  else
    cupsSold = cupsCanMake
  end

  #subtract for the ingredients that were used. All ice melts.
  pitchersMade = (cupsSold/12).ceil
  lemon -= pitchersMade*4
  sugar -= pitchersMade*4
  cups -= cupsSold
  ice = 0

  #increase money made
  moneyMade = cupsSold*(0.25)
  munny += moneyMade
  puts "You sold #{cupsSold} cups of lemonade and made #{moneyMade} munny."
  puts "That is the end of day #{index}"
  puts ""

  index += 1
end
