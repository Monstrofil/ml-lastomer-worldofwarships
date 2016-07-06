__author__ = 'Monstrofil'

import ResMgr
resModPath = ResMgr.openSection('../paths.xml')['Paths'].values()[1]
relCachePath = resModPath.asString + '/scripts/client'

try:
    f = open('../' + resModPath.asString + '/gui/battle_elements.xml', 'rb')
    f.close()
except:
    f = open('../' + resModPath.asString + '/scripts/client/mods/battle_elements.xml', 'rb')
    d = open('../' + resModPath.asString + '/gui/battle_elements.xml', 'wb')
    d.write(f.read())
    d.close()
    f.close()
finally:
    f = open('../' + resModPath.asString + '/gui/battle_elements.xml', 'rb')
    content = f.read()
    f.close()
    if content.find('<element name="XVMBackground" class="XVMBackground" url="XVMBackground.swf"/>') == -1:
        content = content.replace('</elementList>', '''<element name="XVMBackground" class="XVMBackground" url="XVMBackground.swf"/><element name="markersContainer" class="flash.display.Sprite" url="gui_slots.swf"><properties x='0' y='0'/><properties hitTest = "true"/></element></elementList>''')
        content = content.replace('<element name="markersContainer" class="flash.display.Sprite" url="gui_slots.swf">', '<element name="nullelemenet" class="flash.display.Sprite" url="XVMBackground.swf">')
    if content.find('<controller class="XVMDatahubController" clips="XVMBackground"/>') == -1:
        content = content.replace('<controllers>', '<controllers><controller class="XVMDatahubController" clips="XVMBackground"/>')
    f = open('../' + resModPath.asString + '/gui/battle_elements.xml', 'wb')
    f.write(content)
    f.close()



