extends Button

var cards = [
	{"label": "Coup de Dague", "type": "ATTACK", "cost": 4, "effect": 6}, 
	{"label": "Lancé de Dague", "type": "ATTACK", "cost": 3, "effect": 3}, 
	{"label": "Grappin", "type": "CHANGE_RANK", "cost": 3, "effect": 1}, 
	{"label": "A couvert derrière la cheminée", "type": "ARMOR", "cost": 4, "effect": 4}
	]
var rng = RandomNumberGenerator.new()
var selectedCard: int = 0

signal clicked_card(card, node)

func _ready():
	pick_Random_Card()

func pick_Random_Card():	
	rng.randomize()
	selectedCard = rng.randi_range(0, 3)
	$Label.text = cards[selectedCard].label
	$Cost.text = str(cards[selectedCard].cost)
	match cards[selectedCard].type:
			"ATTACK":
				$Effect.text = "Attaque " + str(cards[selectedCard].effect)
			"CHANGE_RANK":
				$Effect.text = "Inconnu"
			"ARMOR":
				$Effect.text = "Armure " + str(cards[selectedCard].effect)

func _on_CardButton_pressed():
	emit_signal("clicked_card", cards[selectedCard], self)
