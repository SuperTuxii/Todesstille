@tool
class_name StyleLabel extends RichTextLabel

@export_multiline
var raw_text: String
@export
var styles: Array[Dictionary] = []
@export_tool_button("Convert Style", "Bake")
var convert_style_action = update_style_text
@export_group("Style")
@export
var style_type: Style
@export
var style_data: String = ""
@export
var style_start_placeholder: String = ""
@export
var style_end_placeholder: String = ""
@export_tool_button("Add Style", "Add")
var add_style_action = add_style

@export_group("Style Presets")
@export_range(1, 10)
var font_size: int = 1

@export
var normal_font: Font = preload("res://assets/fonts/PixelCode2.ttf")
@export
var bold_font: Font = preload("res://assets/fonts/PixelCode-Bold.ttf")
@export
var bold_italics_font: Font = preload("res://assets/fonts/PixelCode-Bold-Italic.ttf")
@export
var italics_font: Font = preload("res://assets/fonts/PixelCode-Italic.ttf")
@export
var mono_font: Font = preload("res://assets/fonts/PixelCode.ttf")

enum Style {BOLD, ITALIC, MONO, URL, HINT, FONT, FONT_SIZE, COLOR, BG_COLOR, FG_COLOR, DUPLICATE}

func _ready() -> void:
	bbcode_enabled = true
	scroll_active = false
	autowrap_mode = TextServer.AUTOWRAP_OFF
	add_theme_font_override("normal_font", normal_font);
	add_theme_font_override("bold_font", bold_font);
	add_theme_font_override("bold_italics_font", bold_italics_font);
	add_theme_font_override("italics_font", italics_font);
	add_theme_font_override("mono_font", mono_font);
	add_theme_font_size_override("normal_font_size", 9 * font_size);
	add_theme_font_size_override("bold_font_size", 9 * font_size);
	add_theme_font_size_override("bold_italics_font_size", 9 * font_size);
	add_theme_font_size_override("italics_font_size", 9 * font_size);
	add_theme_font_size_override("mono_font_size", 9 * font_size);
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	texture_repeat = CanvasItem.TEXTURE_REPEAT_DISABLED
	update_style_text()

func add_style() -> void:
	styles.append({
		"type": style_type,
		"data": style_data,
		"start_placeholder": style_start_placeholder,
		"end_placeholder": style_end_placeholder
	})
	notify_property_list_changed()

func update_style_text() -> void:
	clear()
	text = raw_text
	for style in styles:
		if style.type == Style.DUPLICATE:
			var start_pos: int = text.find(style.start_placeholder)
			while start_pos != -1:
				text = text.erase(start_pos, style.start_placeholder.length())
				var end_pos: int = text.find(style.end_placeholder)
				text = text.erase(end_pos, style.end_placeholder.length())
				text = text.insert(end_pos, text.substr(start_pos, end_pos - start_pos).repeat(style.data.to_int()))
				start_pos = text.find(style.start_placeholder)
		else:
			if style.data.is_empty():
				text = text.replace(style.start_placeholder, "[" + get_style_tag(style.type) + "]")
			else:
				text = text.replace(style.start_placeholder, "[" + get_style_tag(style.type) + "=" + style.data + "]")
			text = text.replace(style.end_placeholder, "[/" + get_style_tag(style.type) + "]")
	parse_bbcode(text)

func get_style_tag(type: Style) -> String:
	match type:
		Style.BOLD:
			return "b"
		Style.ITALIC:
			return "i"
		Style.MONO:
			return "code"
		Style.URL:
			return "url"
		Style.HINT:
			return "hint"
		Style.FONT:
			return "font"
		Style.FONT_SIZE:
			return "font_size"
		Style.COLOR:
			return "color"
		Style.BG_COLOR:
			return "bgcolor"
		Style.FG_COLOR:
			return "fgcolor"
	return ""
