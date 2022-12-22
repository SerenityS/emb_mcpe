import time
import pyautogui

from pynput.mouse import Button, Controller as mController
from pynput.keyboard import Key, Controller as kbController

class McpeController:
	def __init__(self):
		self.mouse = mController()
		self.keyboard = kbController()
		
	def runCmd(self, cmd: str):
		if cmd == "left":
			self.l_rotate()
		elif cmd == "right":
			self.r_rotate()
		elif cmd == "Jump":
			self.jump()
		elif cmd == "Step":
			self.step()
		elif cmd == "Swing":
			self.swing()
			
	def l_rotate(self):
		self.mouse.move(-150, 0)
		
	def r_rotate(self):
		self.mouse.move(150, 0)
	
	def swing(self):
		self.mouse.press(Button.left)
		time.sleep(0.5)
		self.mouse.release(Button.left)
	
	def jump(self):
		self.keyboard.press(Key.space)
		time.sleep(0.5)
		self.keyboard.release(Key.space)	
			
	def step(self):
		pyautogui.keyDown('w')
		time.sleep(0.5)
		pyautogui.keyUp('w')
