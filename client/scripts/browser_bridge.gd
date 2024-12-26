extends Node

var js = null

func _ready():
	if Engine.has_singleton("JavaScript"):
		js = Engine.get_singleton("JavaScript")
		js.bind("receive_browser_event", self, "_on_browser_event")
		print("Browser bridge ready and listening for events.")
		
		fetch_user_data()
		read_trades(0)
	else:
		push_warning("Not running in an HTML5 export. JavaScript bridging is unavailable.")

# Fetch user data: getUser and getInventory
func fetch_user_data():
	if not js:
		return
	var user_id = await js.call("getUser")
	print("User ID: ", user_id)

	var admin = await js.call("getAdmin")
	print("User ID: ", user_id)
	
	var inventory = await js.call("getInventory")
	print("Inventory: ", inventory)

# Get amount of a specific item
func get_all_items():
	if not js:
		return
	var all_items = await js.call("getAllItems")
	print("All items available: ", all_items)

# Create a new trade
func create_new_trade(offer_uid: String, offer_amount: float, cost_uid: String, cost_amount: float, bundles: int):
	if not js:
		return
	
	var payload = {
		"offer": {
			"uid": offer_uid,
			"amount": offer_amount
		},
		"cost": {
			"uid": cost_uid,
			"amount": cost_amount
		},
		"bundles": bundles
	}
	
	var result = await js.call("createTrade", payload)
	if result.has("success"):
		print(result["success"])
	elif result.has("error"):
		print("Error: ", result["error"])

# Read trades for a specific page
func read_trades(page: int):
	if not js:
		return
	var trades = await js.call("readTrade", page)
	print("Trades on page ", page + 1, ": ", trades)

# Update (purchase) a trade
func update_trade(trade_uid: String, amount: int):
	if not js:
		return
	var payload = {
		"uid": trade_uid,
		"amount": amount
	}
	var result = await js.call("updateTrade", payload)
	if result.has("success"):
		print(result["success"])
	elif result.has("error"):
		print("Error: ", result["error"])

# Delete a trade
func delete_trade(trade_uid: String):
	if not js:
		return
	var result = await js.call("deleteTrade", trade_uid)
	if result.has("success"):
		print(result["success"])
	elif result.has("error"):
		print("Error: ", result["error"])

# Handle events received from JavaScript
func _on_browser_event(data):
	print("Received event from browser: ", data)
