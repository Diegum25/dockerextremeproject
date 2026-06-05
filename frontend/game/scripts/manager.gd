class_name Manager extends Node

var socket : WebSocketPeer = WebSocketPeer.new()

var websocket_url : String = Utils.getWebSocket()

var playerScene = preload("res://scenes/player.tscn")

var player : CharacterBody3D

var webPlayers : Dictionary = {}

@export var mainMenu : Menu
@export var world : World

var tickTime : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_physics_process(false)
	assert(mainMenu)
	assert(world)

func _physics_process(delta: float) -> void:
	socket.poll()
	var state : WebSocketPeer.State = socket.get_ready_state()
	match(state):
		WebSocketPeer.State.STATE_CLOSED:
			var code : int = socket.get_close_code()
			printerr("Connection to websocket was closed with code %d" % code)
			if ( code == -1 ):
				printerr("Connection was not closed nicely :(")
			set_physics_process(false)
			world.set_physics_process(false)
			mainMenu.message("Connection\nDropped\n:(")
		WebSocketPeer.State.STATE_OPEN:
			tickTime += delta
			if(player != null && tickTime >= 0.5):
				tickTime = 0.0
				var posData = {
					"type":"posData",
					"xyz":player.position
				}
				var json = JSON.stringify(posData)
				socket.send_text(json)
			while socket.get_available_packet_count():
				var packet = socket.get_packet()
				var packetStr = packet.get_string_from_utf8()
				
				# I HAVE NO IDEA WHAT DATA TYPES THESE ARE
				var json : JSON = JSON.new()
				var jsonStatus : Error = json.parse(packetStr)
				if(jsonStatus == OK):
					var jsonData : Dictionary = json.get_data()
					if(jsonData.has("type") and jsonData["type"] == "posDataAll"):
						var players_map : Dictionary = jsonData["data"]
						for id in players_map.keys():
							var player_data = players_map[id]
							var player_position = player_data["xyz"]
							
							var targetPosition = Vector3(player_position[0],player_position[1],player_position[2])
							# A. UPDATE: If the player already exists, just move them
							if webPlayers.has(id):
								var puppet = webPlayers[id]
								# Direct snap (or use lerp() here for smoother movement)
								puppet.global_position = targetPosition
							
							# B. SPAWN: If it's a new player ID, spawn them into the world
							else:
								var new_player = playerScene.instantiate()
								new_player.name = id # Name the node after their unique UUID
								
								# Add them to the Entities container
								world.get_node("Entities").add_child(new_player)
								
								# Set their initial position
								new_player.global_position = targetPosition
								
								# Save a reference in our dictionary so we can track them next frame
								webPlayers[id] = new_player

func sockConnect() -> Error:
	var status : Error = socket.connect_to_url(websocket_url)
	if(status != Error.OK):
		printerr("Manager could not connect to %s" % websocket_url)
		return status

	socket.poll()
	var state : WebSocketPeer.State = socket.get_ready_state()
	
	while(state == WebSocketPeer.State.STATE_CONNECTING):
		await get_tree().create_timer(1).timeout
		socket.poll()
		state = socket.get_ready_state()
		
	if (state != WebSocketPeer.State.STATE_OPEN):
		printerr("Manager could not connect to %s" % websocket_url)
		return FAILED
		
	print("Connected to %s" % websocket_url)
	
	set_physics_process(true)
	world.set_physics_process(true)
	
	player = playerScene.instantiate()
	
	player.set_script(preload("res://scripts/playableplayer.gd"))
	
	player.name = "my son"
	
	world.add_child(player)
	
	return OK
