extends Label

const duration = [ 30, 31, 30, 31, 31 ]
const months = [ "september", "october", "november", "december", "january" ]

const stories = {
	"5": "Oh, un renne, il a l'air inoffensif",
	"8": "J'ai menti, cours pour ta vie !!",
	"11": "Si tu veux t'équiper c'est E d'ailleurs",
	"15": ""
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
		
