extends Node

# Reference to the BrowserBridge node
onready var browser_bridge = $BrowserBridge

func _ready():
	# Connect to the event_received signal from BrowserBridge
	browser_bridge.connect("event_received", self, "_handle_browser_event")

	# Example: Send a test event once the game starts
	send_wallet_event()

# Called whenever the browser sends an event back to Godot
func _handle_browser_event(event_data: Dictionary) -> void:
	if event_data.has("event"):
		var event_type = event_data["event"]
		
		match event_type:
			"wallet":
				process_wallet_event(event_data["contents"])
			"trade_add":
				process_trade_add(event_data["contents"])
			"trade_remove":
				process_trade_remove(event_data["contents"])
			"stock_add":
				process_stock_add(event_data["contents"])
			"create_stock":
				process_create_stock(event_data["contents"])
			_:
				print("Unknown event type: ", event_type)
	else:
		print("Received malformed event data:", event_data)

# Example helper function to send a "wallet" event to the browser
func send_wallet_event():
	var wallet_contents = [
		{
			"name": "item1",
			"hash": "abc123",
			"division": 2,
			"count": 3.5
		},
		{
			"name": "item2",
			"hash": "def456",
			"division": 1,
			"count": 5.0
		}
	]
	browser_bridge.send_event_to_browser("wallet", wallet_contents)

# Example: Handle wallet data from the browser
func process_wallet_event(contents: Array):
	# Do something with the wallet data
	for item in contents:
		print("Wallet item: ", item)
	# ...

func process_trade_add(contents: Array):
	# Logic to handle a trade addition
	# ...
	print("Trade added:", contents)

func process_trade_remove(contents: Array):
	# Logic to remove a trade
	# ...
	print("Trade removed:", contents)

func process_stock_add(contents: Array):
	# Logic to handle stock addition
	# ...
	print("Stock added:", contents)

func process_create_stock(contents: Array):
	# Logic to handle a new stock creation
	# ...
	print("Stock created:", contents)
