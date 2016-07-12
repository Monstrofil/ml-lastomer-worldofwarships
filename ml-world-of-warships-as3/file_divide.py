import sys, os, re
from xml.dom.minidom import parse, parseString

url = sys.argv[1]
outRoot = sys.argv[2]
rootBlock = sys.argv[3]
doc = parse(url)

def writeXML(xmlNode, url):
    prettyXml = xmlNode.toxml()
    with open(outRoot + url, 'wb') as f:
        f.write(prettyXml)

def getParentName(parent):
    name = parent.nodeName
    if 'className' in parent._attrs:
        name = parent._attrs['className'].childNodes[0].nodeValue
    return name

def workWithNodeList(nodeList):   
    for element in nodeList:
        if hasattr(element, 'nodeName'):
            prefix = "ml_" + element.nodeName + "_%s.xml"
            postfix = None
            if element.nodeName == 'block':
                if 'className' in element._attrs and element._attrs['className'].childNodes[0].nodeValue != rootBlock:
                    postfix = getParentName(element.parentNode) + "_" + element._attrs['className'].childNodes[0].nodeValue
                else:
                    workWithNodeList(element.childNodes)
                    
            if element.nodeName == 'css':
                postfix = element._attrs['name'].childNodes[0].nodeValue

            if postfix:
                print prefix % postfix
                
                writeXML(element, prefix % postfix)

                fileref = doc.createElement("xmlpath")
                fileref.setAttribute("value", outRoot + prefix % postfix)
                
                element.parentNode.insertBefore(fileref, element)
                element.parentNode.removeChild(element)

workWithNodeList(doc.documentElement.childNodes)

writeXML(doc, "__root.xml")
