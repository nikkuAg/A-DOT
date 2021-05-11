extends Tabs

onready var richtext = $RichTextLabel/Control
onready var colorRect = $ColorRect
onready var label = $ColorRect/Label
onready var hscroll = $RichTextLabel/HScrollBar
onready var tab = $RichTextLabel/Control
onready var price1 = str2var($RichTextLabel/Control/Panel1/Label.text)
onready var price21 = str2var($RichTextLabel/Control/Panel2/Label3.text)
onready var price22 = str2var($RichTextLabel/Control/Panel2/Label.text)
onready var price32 = str2var($RichTextLabel/Control/Panel3/Label.text)
onready var price33 = str2var($RichTextLabel/Control/Panel3/Label3.text)
onready var price41 = str2var($RichTextLabel/Control/Panel4/Label4.text)
onready var price42 = str2var($RichTextLabel/Control/Panel4/Label.text)
onready var price43 = str2var($RichTextLabel/Control/Panel4/Label3.text)
onready var panels = $RichTextLabel/Control

func _process(delta: float) -> void:
	tab.position.x = -(hscroll.value)

func _ready() -> void:
	global.load_store()
	for item in range(panels.get_child_count()):
		if global.store.boughtP[item] == true:
			panels.get_node("Panel" + str(item+1)).get_node('Button').text = "Select"
		else:
			panels.get_node("Panel" + str(item+1)).get_node('Button').text = "Buy"
	if(global.store.selectedP != -1):
		panels.get_node("Panel" + str(global.store.selectedP+1)).get_node('Button').text = "Selected"
		panels.get_node("Panel" + str(global.store.selectedP+1)).get_node('Button').add_to_group("selectedP")
		

func buy1(price, item_no):
	global.load_store()
	if global.store.boughtP[item_no]==false:
		if PlayerStats.Ggem1 >= price:
			PlayerStats.Ggem1 -= price
			global.store.boughtP[item_no] = true
			panels.get_node("Panel" + str(item_no+1)).get_node('Button').text = "Select"
			global.save_store()
		else:
			colorRect.show()
			label.text = "You do not have enough gems and jwels."
	else:
		selected(panels.get_node("Panel" + str(item_no+1)).get_node('Button'), item_no)
		
func buy2(price,price2,item_no):
	global.load_store()
	if global.store.boughtP[item_no]==false:
		if PlayerStats.Ggem1 >= price and PlayerStats.Ggem2 >=price2:
			PlayerStats.Ggem1 -= price
			PlayerStats.Ggem2 -= price2
			global.store.boughtP[item_no] = true
			panels.get_node("Panel" + str(item_no+1)).get_node('Button').text = "Select"
			global.save_store()
		else:
			colorRect.show()
			label.text = "You do not have enough gems and jwels."
	else:
		selected(panels.get_node("Panel" + str(item_no+1)).get_node('Button'), item_no)

func buy3(price,price2,item_no):
	global.load_store()
	if global.store.boughtP[item_no]==false:
		if PlayerStats.Ggem2 >= price and PlayerStats.Ggem3 >= price2:
			PlayerStats.Ggem2 -= price
			PlayerStats.Ggem3 -= price2
			global.store.boughtP[item_no] = true
			panels.get_node("Panel" + str(item_no+1)).get_node('Button').text = "Select"
			global.save_store()
		else:
			colorRect.show()
			label.text = "You do not have enough gems and jwels."
	else:
		selected(panels.get_node("Panel" + str(item_no+1)).get_node('Button'), item_no)
		
		
func buy4(price,price2, price3, item_no):
	global.load_store()
	if global.store.boughtP[item_no]==false:
		if PlayerStats.Ggem1 >= price and PlayerStats.Ggem2 >= price2 and PlayerStats.Ggem3 >= price3:
			PlayerStats.Ggem1 -= price
			PlayerStats.Ggem2 -= price2
			PlayerStats.Ggem3 -= price3
			global.store.boughtP[item_no] = true
			panels.get_node("Panel" + str(item_no+1)).get_node('Button').text = "Select"
			global.save_store()
		else:
			colorRect.show()
			label.text = "You do not have enough gems and jwels."
	else:
		selected(panels.get_node("Panel" + str(item_no+1)).get_node('Button'), item_no)


func selected(node, no):
	global.load_store()
	for button in get_tree().get_nodes_in_group("selectedP"):
		button.text = "Select"
		button.remove_from_group("selectedP")
	node.text = "Selected"
	node.add_to_group("selectedP")
	global.store.selectedP = no
	global.save_store()

func _on_Button1_button_up() -> void:
	buy1(price1,0)


func _on_Button2_button_up() -> void:
	buy2(price21,price22, 1)


func _on_Button3_button_up() -> void:
	buy3(price32, price33, 2)


func _on_Button4_button_up() -> void:
	buy4(price41, price42, price43, 3)



func _on_Button_button_up() -> void:
	colorRect.hide()


