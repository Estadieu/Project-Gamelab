extends Label

const duration = [ 30, 31, 30, 31, 31 ]
const months = [ "september", "october", "november", "december", "january" ]

const stories = {
	"5": "Oh, a reindeer, it looks harmless",
	"8": "It's an invasion, I have to run !!",
	"11": "If you want to equip yourself press E",
	"15": "It seems to be getting darker and darker.",
	"20":"and the danger is increasing day by day.",
	"25": "",
	"190": "Wow foxes they are so fast",
	"210": "It's really black, I can't see anything anymore",
	"245": "",
}

func _ready():
	$Story.text = ""

func _on_time_updated(time):
	# Date
	var month = floor(time / 60)

	if month >= months.size():
		text = "Happy ending"
		return

	var day = round((time % 60) * duration[month] / 60) + 1

	text = str(day) + " " + months[month]

	# Story
	if str(time) in stories:
		var tween = create_tween()
		tween.tween_property($Story, "modulate", Color(0, 0, 0, 0.0), 0.25)
		tween.tween_callback(func(): $Story.text = stories[str(time)])
		tween.tween_property($Story, "modulate", Color(0, 0, 0, 1.0), 0.25)
		tween.play()
