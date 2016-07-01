import os, sys

imports = []
vars = []

print os.walk("src"), "sdfsdf"

for root, subdirs, files in os.walk("src"):
    for file in files:
        if file.endswith(".as") and not '__Global' in file:
            import_path = os.path.join(root, file).replace("src/", '').replace("\\", '.').replace('.as', '')
            class_name = import_path.replace('.', '_')
            
            print "    import %s;"%import_path
            print "        var %s:%s;"%(class_name, import_path)
            
            imports.append("    import %s;"%import_path)
            vars.append("        public var _%s:%s;"%(class_name, import_path))

template = ""
with open("local/__Global.template") as f:
    template = f.read()
    template = template.replace("{imports}", os.linesep.join(imports))
    template = template.replace("{variables}", os.linesep.join(vars))
    
with open("src/__Global.as", 'wb') as f:
    f.write(template)
