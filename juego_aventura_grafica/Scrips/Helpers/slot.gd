extends PanelContainer

@onready var texture_rect = $MarginContainer/TextureRect

func setItem(item: ItemData):
	texture_rect.texture=item.icon
	tooltip_text=item.type
