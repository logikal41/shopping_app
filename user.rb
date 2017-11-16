# User class
class User
	attr_accessor :user, :wallet_amt, :cart

	# Initialize user object
	def initialize
		# Ask for initial user information
		print "Please enter the user's name: "
		@user = gets.chomp
		print "How much money does #{@user} have? "
		@wallet_amt = gets.to_f
		until @wallet_amt != 0  # Make sure the uset inputs a number
			print "Invalid entry. How much money does #{@user} have? "
			@wallet_amt = gets.to_f
		end
		@cart = []
	end

	# Instance method to buy an item
	def buy(store)
		print "Enter the item you want to purchase or press <enter> to go back: "
		item = gets.chomp.downcase
		item = store.check_inventory(item) # check store inventory
		if item != ""
			quantity = store.check_quantity(item) # check if item has stock
			if quantity != 0
				if @wallet_amt > store.get_price(item) # Check if the user has enough money
					puts "You paid $%.2f for a #{item}" % store.get_price(item)
					@wallet_amt -= store.get_price(item) # reduce wallet_amt by item price
					@cart << item # add item to the cart
					store.increment(item,"buy") #increment the inventory
				else
					puts "You do not have enough money to purchase a #{item}."
				end	
			end
		end
	end

	# Instance method to return an item to the store
	def sell(store)
		print "Enter the item you want to return or press <enter> to go back: "
		item = gets.chomp.downcase
		if @cart.include?(item)
			@wallet_amt += store.get_price(item) # increase wallet_amt by item price
			@cart.delete_at(@cart.find_index(item)) # remove item from cart
			store.increment(item,"sell") #increment the inventory
			puts "You returned #{item} and got $%.2f back." % store.get_price(item)		
		else
			puts "You can not return an item you did not buy."
		end
	end

	# Instance method to display current shopping cart
	def print_cart
		puts "----- #{@user}'s Shopping Cart -----"
		if @cart.length > 0
			@cart.each do |item|
				puts "> #{item}"
			end
		else
			puts "Your shopping list is empty."
		end
		puts "--------------------------------"
	end

	# Instance method to get the total cost of the cart
	def get_total(store)
		cost = 0 # Initial cost
		if @cart.length > 0
			@cart.each do |item|
				if store.prices.include?(item.to_sym) # error handling if an item is removed from inventory
					cost += store.get_price(item) # Add all items in the list to the cost variable
				else
					next
				end
			end
			return cost
		else
			return 0
		end
	end

end # end of class