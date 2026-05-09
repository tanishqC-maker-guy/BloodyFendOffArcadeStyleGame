'''
Coded by Tanishq Chigullarevu
2026
'''
extends ColorRect

'''
This is the script for the blood meter at the top of the screen,
which handles it's real time updating.
'''

#this always checks the bullet count to make the blood bar accurate to how many shots you got left.
func _process(_delta):
	#The checking all the time is paused when the blood bonus is added so the bar actually shrinks during the bonus count
	if not(GeneralVarsScript.isCountingScore):
		var bloodBarLength = float(GeneralVarsScript.bulletCount)/float(40)
		self.scale = Vector2(bloodBarLength, 1)
