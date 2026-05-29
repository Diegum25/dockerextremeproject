class_name Utils extends Node

enum GameClient {
	WEB,
	COMPUTER
}

static func getWebSocket() -> String:
	if(OS.has_feature("web")):
		var host = String(JavaScriptBridge.eval("window.location.origin"))
		
		var prefix : String
		
		if (host.begins_with("https")):
			prefix = "wss"
		else:
			prefix = "ws"
		
		return prefix+host.lstrip('https')+"/api/ws/"
	else:
		return 'ws://localhost:4001/'

static func getGameClient() -> GameClient:
	if(OS.has_feature("web")):
		return GameClient.WEB
	else:
		return GameClient.COMPUTER
