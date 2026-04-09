@tool
extends EditorPlugin

const SHEET_ID = "1GIheD0G__7Hy1a2C33OuhzQ7uKiyyZBZRnHkdwPYDwo"
const EXPORT_URL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vSVc1EDLJzQJfe6VRz2hcgayCvrYudb7Z8M9L5aH2dkSkkRBSsDRsD2JqEE-CdAWNlB_0AYWBcWGOip/pub?gid=0&single=true&output=csv"
const SAVE_PATH = "res://data/word_database.tres"

var http := HTTPRequest.new()

func _enter_tree() -> void:
	add_tool_menu_item("Refresh word database", _on_refresh_pressed)
	add_child(http)
	http.set_max_redirects(50)


func _exit_tree() -> void:
	remove_tool_menu_item("Refresh word database")
	if http: http.queue_free()

func _on_refresh_pressed() -> void:
	print("Starting word database refresh...")	
	if !http.request_completed.is_connected(_on_request_completed):
		http.request_completed.connect(_on_request_completed)
	var err = http.request(EXPORT_URL)


func _on_request_completed(result, response_code, headers, body) -> void:
	if response_code != 200:
		if response_code == 307: # 307 = temporary response code
			for header: String in headers:
				if header.begins_with("Location: "):
					var new_url = header.trim_prefix("Location:").strip_edges()
					var err = http.request(new_url)
		return
	
	var csv_text = body.get_string_from_utf8().strip_edges()
	var lines = csv_text.split("\n")
	var db = load(SAVE_PATH) as WordDatabase
	if !db : 
		db = WordDatabase.new()
	db.database.clear()
	for i in range(1, lines.size()):
		var row = lines[i].split(",")
		if row.size() >= 3:
			var word := Word.new()
			word.english = row[0]
			word.polish = row[1]
			word.lithuanian = row[2]
			db.database.append(word)

	if not DirAccess.dir_exists_absolute("res://data/"):
		DirAccess.make_dir_recursive_absolute("res://data/")
		
	var save_err = ResourceSaver.save(db, SAVE_PATH, ResourceSaver.FLAG_NONE)
	if save_err == OK:
		print("Successfully saved WordDatabase to: ", SAVE_PATH)
		# Forces the editor to see the new/updated file immediately
		EditorInterface.get_resource_filesystem().update_file(SAVE_PATH)
		get_editor_interface().get_resource_filesystem().scan()
	else:
		printerr("Failed to save resource. Error code: ", save_err)
