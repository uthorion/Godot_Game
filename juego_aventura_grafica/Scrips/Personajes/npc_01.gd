extends Area2D

var dialogs_npc_01 = [
	# 0
	"Un hombre sentado en un banco te mira cuando te acercas",
	# 1
	{
		"options": [
			{ "text": "hola, ¿puede decirme donde estoy?", "next": 2 },
			{ "text": "disculpe, ¿quién es usted?", "next": 4 },
			{ "text": "(mejor no molestarlo)", "next": -1 }
		]
	},

	# 2 - respuesta a "¿dónde estoy?"
	"sí, pero eso arruinaría la sorpresa, por lo que voy a tener que declinar esa petición.",
	# 3
	{
		"options": [
			{ "text": "¿qué sorpresa está hablando? oiga, disculpe pero estoy perdido, creo que choqué y...", "next": 10 },
			{ "text": "(genial, me tuvo que tocar el loco)", "next": 6 }
		]
	},

	# 4 - respuesta a "¿quién es usted?"
	"No tiene relevancia eso, lo que importa es que finalmente has llegado.",
	# 5
	{
		"options": [
			{ "text": "¿finalmente he llegado? este lugar ni siquiera lo conozco y usted no me suena", "next": 8 }
		]
	},

	# 6 - rama de "(me tocó el loco)"
	"no estoy loco amigo mío, y espero que sepas que tratar de loco a desconocidos no es apreciado en ningún lugar.",
	# 7
	{
		"options": [
			{ "text": "¿¿Cómo ha??", "next": 10 }
		]
	},

	# 8 - rama de "usted me suena"
	"pero yo sí le conozco a usted, pero ese tampoco es el punto.",
	# 9
	{
		"options": [
			{ "text": "¿pero de qué está hablando? cada vez me confunde más", "next": 10 }
		]
	},

	# 10 - convergencia
	"no se preocupe por eso ahora, le recomiendo que deje de pensar en lo que le sucedió y comience a pensar en lo que está en su situación actual.",
	# 11
	"no puedo contarle demasiado, pero le puedo decir que debe continuar adelante, pasando la plaza hay una puerta solo para usted...",
	# 12
	{
		"options": [
			{ "text": "¿una puerta? ¿para qué yo voy a querer pasar a alguna puerta?", "next": 13 },
			{ "text": "(me voy, no puedo seguir hablando con este pirado)", "next": 14 }
		]
	},
	# 13
	"no se preocupe, todas sus preguntas serán respondidas, pero no por mí. Lo único que le digo es que no podrá irse de la plaza a menos que sea por esa puerta",
	# 14
	"no tiene sentido pensar en irse, tampoco es que hay otra salida más que la puerta."
]

func _ready():
	input_event.connect(_on_area_input)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_area_input(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GESTORDIALOGOS.show_external_dialog(dialogs_npc_01)

func _on_mouse_entered():
	CURSORMANAGER.set_cursor_boca()


func _on_mouse_exited():
	CURSORMANAGER.set_cursor_default()
