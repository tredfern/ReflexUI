#macro REFLEX_GLOBAL global.__reflex
#macro REFLEX_ROOTS REFLEX_GLOBAL.roots
#macro REFLEX_STYLESHEET REFLEX_GLOBAL.stylesheet


// Properties
#macro REFLEX_PROPERTY_PADDING			"padding"
#macro REFLEX_PROPERTY_MARGIN			"margin"
#macro REFLEX_PROPERTY_BORDER			"border"
#macro REFLEX_PROPERTY_BACKGROUNDCOLOR	"backgroundColor"
#macro REFLEX_PROPERTY_BORDERCOLOR		"borderColor"
#macro REFLEX_PROPERTY_STYLES			"styles"

enum ReflexLayout {
	block,
	inline
}

enum ReflexProperty {
	inherit = -32500,
	off = -32499,
	auto = -32498
}

enum ReflexPosition {
	relative,
	absolute
}