extends Sprite2D

var roll_interval := 0.2
var time_left := 0.0

func _ready() -> void:
	randomize()
	set_process(true)
	time_left = roll_interval
	
	# Start fully visible by setting alpha to 1.0
	self_modulate.a = 1.0

func _process(delta: float) -> void:
	time_left -= delta
	if time_left <= 0.0:
		var r = randf()
		
		if self_modulate.a == 1.0: # ON
			# 5% chance to go "OFF" (alpha = 0.0)
			if r < 0.05:
				# if OFF, what opacity?
				if randf() < 0.5: 
					self_modulate.a = 0.0
				else:
					self_modulate.a = 0.5
		else: # OFF
			# 70% chance to go "ON" (alpha = 1.0)
			if r < 0.70:
				self_modulate.a = 1.0
			else:
				self_modulate.a = 0.8
		
		# Reset the timer
		time_left = roll_interval
