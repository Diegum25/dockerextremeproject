class_name Utils extends Node

enum GameClient {
	WEB,
	COMPUTER
}

static func whereAmI() -> String:
	if(OS.has_feature("web")):
		var host = String(JavaScriptBridge.eval("window.location.origin"))
		return "wss"+host.lstrip('https')
	else:
		return 'ws://localhost:4001/'

static func getGameClient() -> GameClient:
	if(OS.has_feature("web")):
		return GameClient.WEB
	else:
		return GameClient.COMPUTER
