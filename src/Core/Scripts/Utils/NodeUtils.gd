extends Object
class_name NodeUtils

## Devuelve todos los nodos hijos directos que sean del tipo indicado.
## 
## @param node El nodo padre del cual se revisarán los hijos
## @param type_name Nombre de clase registrado con `class_name`
## @return Array con los nodos que coinciden con el tipo
static func GetChildrenOfType(node: Node, type_name: String) -> Array:
	var result: Array = []
	
	for child in node.get_children():
		if child.is_class(type_name):
			result.append(child)
	
	return result


## Verifica si existe al menos un hijo directo del tipo indicado.
##
## Útil cuando solo necesitas saber si el componente existe
## sin tener que obtener la referencia completa.
##
## @param node El nodo padre del cual se revisarán los hijos
## @param type_name Nombre de clase registrado con `class_name`
## @return `true` si se encontró al menos un hijo de ese tipo, de lo contrario `false`
static func HasChildrenOfType(node: Node, type_name: String) -> bool:
	var hasChildren: bool = false
	
	for child in node.get_children():
		if child.is_class(type_name):
			hasChildren = true
			break
	
	return hasChildren


## Devuelve el primer hijo directo que coincida con el tipo indicado.
##
## Más eficiente que obtener la lista completa si solo necesitas uno.
##
## @param node El nodo padre del cual se revisarán los hijos
## @param type_name Nombre de clase registrado con `class_name`
## @return El primer nodo que coincida con el tipo, o `null` si no existe
static func GetFirstChildOfType(node: Node, type_name: String) -> Node:
	for child in node.get_children():
		if child.is_class(type_name):
			return child
	return null
