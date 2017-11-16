# Store Class
class Store
	attr_accessor :store_name, :prices, :quantities

	#Initialize store object
	def initialize(store_name = "Staples")
		@store_name = store_name
		#Hard code in the inventory for now
		@prices = {chair: 45.00, desk: 99.00, lights: 35.00, printer: 129.99, paper: 19.99, pencil: 4.99}
		@quantities = {chair: 4, desk: 2, lights: 3, printer: 1, paper: 10, pencil: 25}
	end

	# Instance method for printing store menu and getting user input
	def menu
		print """Menu:
1. Current Store Name
2. Store Inventory
3. Add Item To Inventory
4. Remove Item From Inventory
5. Adjust Inventory Quantities
6. Return To Main Menu
> """
		action = gets.chomp
	end

	# Instance method to print the inventory to console
	def print_inventory
		puts "------ Inventory ------"
		@prices.each do |item, price|
			puts "#{item}:\t$%.2f,\t#{quantities[item.to_sym]} in stock" % price
		end
		puts "-----------------------"
	end

	# Instance method to increment the inventory
	def increment(item, type)
		if type == "buy"
			@quantities[item.to_sym] -= 1
		else
			@quantities[item.to_sym] += 1
		end
	end

	# Instance method to check inventory
	def check_inventory(item)
		until @prices.include?(item.to_sym) # Does the hash include the item?
			if item != ""
				puts "This store does not have a #{item} in inventory."
				print "Please select a valid item or press <enter> to go back: "
				item = gets.chomp.downcase # make the input lowercase
			else
				break # user hit <enter>
			end
		end
		return item
	end

	# Instance method to check quantity in stock
	def check_quantity(item)
		quantity = @quantities[item.to_sym]
			if quantity == 0
				puts "#{item} is OUT OF STOCK."
			end
		return quantity
	end

	# Instance method to add an item to the inventory
	def add_inventory
		print "What item would you like to add to the store's inventory? "
		new_item = gets.chomp.downcase
		if @prices.include?(new_item.to_sym)
			puts "#{new_item} is already in the inventory"
		else
			print "What is the retail price of #{new_item}? " # need error checking for float
			price = gets.to_f
			@prices[new_item.to_sym] = price
			print "How many #{new_item}/s are you adding to the inventory? " # need error checking
			quantity = gets.to_i
			@quantities[new_item.to_sym] = quantity
			puts "#{quantity} #{new_item}/s successfully added to the inventory."
		end
	end

	# Instance method to add an item to the inventory
	def remove_inventory
		print_inventory
		print "What item would you like to remove from the store's inventory? "
		item = gets.chomp.downcase
		item = check_inventory(item)
		if item == ""
			puts "Invalid item. No changes to inventory."
		else
			@prices.delete(item.to_sym)
			@quantities.delete(item.to_sym)
			puts "#{item} has been removed from inventory."
		end
	end

	# Instance method to add an item to the inventory
	def edit_quantity
		print_inventory
		print "What item's quantity would you like to change? "
		item = gets.chomp.downcase
		item = check_inventory(item)
		if item == ""
			puts "No changes to #{item} quantity."
		else
			print "What is the new quantity? "
			quantity = gets.chomp
			if quantity == "0"
				@quantities[item.to_sym] = quantity.to_i
				puts "#{item} quantity has been updated."
			elsif quantity.to_i > 0
				@quantities[item.to_sym] = quantity.to_i
				puts "#{item} quantity has been updated."
			else
				puts "Invalid quantity."
			end
		end
	end

	# Instance method to get price of item
	def get_price(item)
		@prices[item.to_sym]
	end

	# Instance method for going shopping
	def store_options
		action = menu
		# case list
		case action
		when "1"                          # Display current store name
			puts "Store Name: #{@store_name}"
		when "2"                          # Display the store inventory
			print_inventory
		when "3"                          # Add item to the inventory
			add_inventory
		when "4"
			remove_inventory              # Remove an item from inventory
		when "5"                          # Adjust inventory quantity
			edit_quantity		
		when "6"                          # Exit the program
			return "Returning to the main menu."
		else                              # Menu item error handling
			puts "Invalid option. Please enter a valid menu option."
		end
		store_options                           # call itself again (recursion to avoid while loop)
	end

end
