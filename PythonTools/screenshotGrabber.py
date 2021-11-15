# -*- coding: utf-8 -*-
"""
Created on Tue Oct  5 19:43:05 2021

@author: Collin Clark
"""

#%%

#imports

import wx 
import os
import ftplib

#%%

w = wx.App()
screen = wx.ScreenDC()
size = screen.GetSize()
bmap = wx.Bitmap(size[0],size[1])
memo = wx.Memory(bmap)
memo.Blit(0, 0, size[1], size[1], screen,0,0)

del memo

bmap.SaveFile("Grabbed_Screen.png", wx.BITMAP_TYPE_PNG)

#%%

