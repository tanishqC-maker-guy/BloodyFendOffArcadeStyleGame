'''
Coded by Tanishq Chigullarevu
2026
'''
extends Node2D

'''
This is the script for the highscore board, which handles
adding your highscore to the board.
'''

#this holds the all the possible symbols the player can use for their nickname
var sourceLetterString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ._?!()"

#this represents the number of empty spaces remaining
var remainingSpaces = 2

#this shows how much of the nickname is complete
var completedSpaces = ""

#this is the index of the sourceLetterString string we're on which shows which letter we want to type in
var letterWeAreOn = 0

#this is used to prevent the letter flipping from going too fast
var letterFlipCooldown = false

func _process(_delta):
	#this checks if we are entering the nickname for a highscore and the cooldown to change a letter is finished
	if letterFlipCooldown == false and GeneralVarsScript.isEnteringNickname:
		#this controls which letter we want to add to the nickname
		#if we press W we go forward in the letters
		if (Input.is_key_pressed(KEY_W)):
			letterWeAreOn = letterWeAreOn + 1
			$ShootBullet8Bit.play()
		#if we press S we go backward in the letters
		elif (Input.is_key_pressed(KEY_S)):
			letterWeAreOn = letterWeAreOn - 1
			$ShootBullet8Bit.play()
		#here if we press enter a few things could happen
		elif (Input.is_key_pressed(KEY_ENTER)):
			#if we still have a few letters of the nickname to finish we add the letter we selected to the amount of the nickname we already finished
			if (remainingSpaces > 0):
				completedSpaces = completedSpaces + str(sourceLetterString[letterWeAreOn])
				remainingSpaces = remainingSpaces - 1
				$Damaged8Bit.play()
			#if all the letters are filled, we now update the highscore board to show how the new score stacks against the older ones
			else:
				#here we define all the old highscores' names and scores, as well as the new name and score
				var newPlayerScore = GeneralVarsScript.scoreNumber
				var firstScore = int($highPlaceTextLabel.text.substr(12))
				var secondScore = int($highPlaceTextLabel2.text.substr(12))
				var thirdScore = int($highPlaceTextLabel3.text.substr(12))
				var fourthScore = int($highPlaceTextLabel4.text.substr(12))
				var fifthScore = int($highPlaceTextLabel5.text.substr(12))
				var sixthScore = int($highPlaceTextLabel6.text.substr(12))
				
				var playerName = $LetterInputLabel.text
				var firstName = $highPlaceTextLabel.text.substr(8, 3)
				var secondName = $highPlaceTextLabel2.text.substr(8, 3)
				var thirdName = $highPlaceTextLabel3.text.substr(8, 3)
				var forthName = $highPlaceTextLabel4.text.substr(8, 3)
				var fifthName = $highPlaceTextLabel5.text.substr(8, 3)
				var sixthName = $highPlaceTextLabel6.text.substr(8, 3)
				
				#now we put all the scores in a list and sort them inside it to see what the final board will look like
				var newScorePlaces = [[firstScore, firstName], [secondScore, secondName], [thirdScore, thirdName], [fourthScore, forthName], [fifthScore, fifthName], [sixthScore, sixthName], [newPlayerScore, playerName]]
				newScorePlaces.sort()
				
				#here we replace the board text with the new scores
				$highPlaceTextLabel.text = "1ST     " + str(newScorePlaces[6][1]) + " " + str(newScorePlaces[6][0])
				$highPlaceTextLabel2.text = "2ND     " + str(newScorePlaces[5][1]) + " " + str(newScorePlaces[5][0])
				$highPlaceTextLabel3.text = "3RD     " + str(newScorePlaces[4][1]) + " " + str(newScorePlaces[4][0])
				$highPlaceTextLabel4.text = "4TH     " + str(newScorePlaces[3][1]) + " " + str(newScorePlaces[3][0])
				$highPlaceTextLabel5.text = "5TH     " + str(newScorePlaces[2][1]) + " " + str(newScorePlaces[2][0])
				$highPlaceTextLabel6.text = "6TH     " + str(newScorePlaces[1][1]) + " " + str(newScorePlaces[1][0])
				
				SavingScript.contents_to_save.score_1 = newScorePlaces[6][0]
				SavingScript.contents_to_save.score_2 = newScorePlaces[5][0]
				SavingScript.contents_to_save.score_3 = newScorePlaces[4][0]
				SavingScript.contents_to_save.score_4 = newScorePlaces[3][0]
				SavingScript.contents_to_save.score_5 = newScorePlaces[2][0]
				SavingScript.contents_to_save.score_6 = newScorePlaces[1][0]
				
				
				SavingScript.contents_to_save.nickname_1 = newScorePlaces[6][1]
				SavingScript.contents_to_save.nickname_2 = newScorePlaces[5][1]
				SavingScript.contents_to_save.nickname_3 = newScorePlaces[4][1]
				SavingScript.contents_to_save.nickname_4 = newScorePlaces[3][1]
				SavingScript.contents_to_save.nickname_5 = newScorePlaces[2][1]
				SavingScript.contents_to_save.nickname_6 = newScorePlaces[1][1]
				
				SavingScript._save()
				
				#now we change the insert coin text and disable entering the nickname and cooldown
				$"../InsertCoinLabel".text = "INSERT COIN"
				letterFlipCooldown = true
				await get_tree().create_timer(0.8).timeout
				letterFlipCooldown = false
				GeneralVarsScript.isEnteringNickname = false
				
		#now if the letter we choose gets to an index outside of the sourceLetterString, we just reset it back to the beginning
		if letterWeAreOn > 31:
			letterWeAreOn = 0
		elif letterWeAreOn < 0:
			letterWeAreOn = 31
		
		#Now we make the LetterInputLabel display the currently made nickname
		$LetterInputLabel.text = completedSpaces + str(sourceLetterString[letterWeAreOn]) + "_".repeat(remainingSpaces)
		
		letterFlipCooldown = true
		await get_tree().create_timer(0.2).timeout
		#we turn off the letter flip cooldown
		letterFlipCooldown = false
		if (not GeneralVarsScript.isEnteringNickname):
			remainingSpaces = 2
			completedSpaces = ""
			letterWeAreOn = 0


func _ready():
	$highPlaceTextLabel.text = "1ST     " + SavingScript.contents_to_save.nickname_1 + " " + str(SavingScript.contents_to_save.score_1)
	$highPlaceTextLabel2.text = "2ND     " + SavingScript.contents_to_save.nickname_2 + " " + str(SavingScript.contents_to_save.score_2)
	$highPlaceTextLabel3.text = "3RD     " + SavingScript.contents_to_save.nickname_3 + " " + str(SavingScript.contents_to_save.score_3)
	$highPlaceTextLabel4.text = "4TH     " + SavingScript.contents_to_save.nickname_4 + " " + str(SavingScript.contents_to_save.score_4)
	$highPlaceTextLabel5.text = "5TH     " + SavingScript.contents_to_save.nickname_5 + " " + str(SavingScript.contents_to_save.score_5)
	$highPlaceTextLabel6.text = "6TH     " + SavingScript.contents_to_save.nickname_6 + " " + str(SavingScript.contents_to_save.score_6)
