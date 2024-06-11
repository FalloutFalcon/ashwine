/// Display a DM icon in a a browser.
/proc/icon_element(icon, state, dir, moving, frame, style)
	return "<img class='dmIcon' src='\ref[icon]?state=[state]&dir=[dir]&moving=[moving]&frame=[frame]' style='[style]'>"

