extends Node2D

var cardsAmount: int = 5
var ennemyLife: int = 50
var playerArmor: int = 0
var playerLife: int = 50
var playerPa: int = 10
var totlaEnnemyLife: int = 50
var totalPlayerLife: int = 50
var totalPlayerPa: int = 10

func _process(_delta):
	$Player/PlayerLife.text = str(playerLife) + "/" + str(totalPlayerLife)
	$Ennemy/EnnemyLife.text = str(ennemyLife) + "/" + str(totlaEnnemyLife)
	$GUI/CardSelectionZone/PaAmount/PaAmountCount.text = str(playerPa) + "/" + str(totalPlayerPa)
	
	if playerPa <= 0:
		reset_Cards()

func attack_Ennemy(attackAmount):
	if ennemyLife > 0:
		ennemyLife -= attackAmount
	if ennemyLife < 0:
		ennemyLife = 0

func add_Armor_To_Player(armorAmount):
	playerArmor += armorAmount
	$Player/PlayerArmor.text = str(playerArmor)
	$Player/PlayerArmor.visible = true

func check_Cards_Amount():
	cardsAmount -= 1
	if cardsAmount == 0:
		reset_Cards()

func reset_Cards():
	playerPa = 10
	cardsAmount = 5
	for child in $GUI/CardSelectionZone/AvailableCards.get_children():
		child.pick_Random_Card()
		child.visible = true

# SIGNALS
func _on_CardButton_clicked_card(card, node):
	if (playerPa - card.cost) >= 0:
		node.visible = false
		playerPa -= card.cost		
		check_Cards_Amount()
		
		match card.type:
			"ATTACK":
				attack_Ennemy(card.effect)
			"CHANGE_RANK":
				print("Changement de rang")
			"ARMOR":
				add_Armor_To_Player(card.effect)

func _on_Button_pressed():
	reset_Cards()
