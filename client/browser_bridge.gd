extends Node

signal event_received(event_data)

func _ready():
	# Only bind JavaScript functions if we're running in an HTML5 environment.
	if Engine.is_html5():
		JavaScript.bind("receive_browser_event", self, "_on_browser_event")
		print("Browser bridge ready and listening for events.")
	else:
		push_warning("Not running in an HTML5 export. JavaScript bridging is unavailable.")

# Sends an event to the browser
func send_event_to_browser(event_type: String, contents: Array) -> void:
	if not Engine.is_html5():
		push_warning("Cannot send event to browser because we are not in an HTML5 build.")
		return

	# Create a JSON object and stringify
	var data := {
		"event": event_type,
		"contents": contents
	}
	var json := JSON.new()
	var json_string := json.stringify(data)

	# Use JavaScript.eval() to call a function in the browser
	JavaScript.eval("handleGodotEvent(" + json_string + ")")
	print("Sent event to browser:", json_string)

# Handles events received from the browser
func _on_browser_event(json_string: String) -> void:
	var json := JSON.new()
	var err := json.parse(json_string)

	if err == OK:
		var data = json.get_data()
		emit_signal("event_received", data)
		print("Event received from browser:", data)
	else:
		push_error("Invalid JSON received from browser: " + json_string)
