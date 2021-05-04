"""
    Plugin for Launching programs
"""

# -*- coding: UTF-8 -*-
# main imports
import sys
import os
import xbmc
import xbmcgui
import xbmcaddon

# plugin constants
__plugin__ = "X11-launcher"
__author__ = "Zjoasan"
__url__ = "https://github.com/zjoasan/"
__git_url__ = "https://github.com/zjoasan/"
__credits__ = "mcobit"
__version__ = "0.0.3"

dialog = xbmcgui.Dialog()
addon = xbmcaddon.Addon(id='plugin.program.x11-launcher')

output=os.popen("/home/osmc/x11-start/xstart.sh").read()

