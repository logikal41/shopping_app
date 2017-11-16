# Require statements
require 'pry'
require_relative 'user' # pull in the user class
require_relative 'store' # pull in the store class

# Create App class
class App
	attr_accessor :user, :store
	
	# Initialize App object
	def initialize
		@user = User.new # create new user
		@store = Store.new # create new store, can add inventory list here later
		go_shopping
	end

	# Instance method for printing menu and getting user input
	def menu
		print """Menu:
1. Store Inventory
2. Make a Purchase
3. Return an Item
4. Current Shopping Cart
5. Store Options
6. Quit
> """
		action = gets.chomp
	end

	# Instance method for going shopping
	def go_shopping
			action = menu
			# case list
			case action
			when "1"                          # Display the store inventory
				@store.print_inventory
			when "2"                          # Buy something
				@store.print_inventory        # Print store inventory
				@user.buy(@store)             # User makes a purchase
			when "3"
				@user.print_cart              # Print current shopping cart
				@user.sell(@store)            # Return an item to the store
			when "4"                          # Display the shopping cart and wallet_amt
				@user.print_cart
				puts "Your total will be: $%.2f" % @user.get_total(@store)
				puts "You have $%.2f remaining in your wallet." % @user.wallet_amt
			when "5"                          # Enter the store's options
				@store.store_options
			when "6"                          # Exit the program
				exit
			else                              # Error handling
				puts "Invalid option. Please enter a valid menu option."
			end
		go_shopping                           # call itself again (recursion to avoid while loop)
	end

end

# Call the app class and start the script
tony = App.new()



# add in the below menu options
# create new store
# switch stores to shop at



# ----- Bonus: ------

# add in the below menu options
# create new store
# switch stores to shop at
 # Create multiple stores and allow users to shop at different stores with different inventory


