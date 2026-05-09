'''
Coded by Tanishq Chigullarevu
2026
'''
extends Label

'''
This is the script for the score text, which handles
the real time display of the score.
'''

#this always makes sure that the score text is displaying the correct updated score at all times
func _process(_delta):
	self.text = "Score: " + str(GeneralVarsScript.scoreNumber)
