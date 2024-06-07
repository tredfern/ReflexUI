#macro REFLEXUI							global.__reflex			// Global container for internal data for the library
#macro REFLEXUI_USER_CONFIGURATION		global.__reflexUserConfiguration



// Properties
#macro REFLEX_PROPERTY_ANIMATION_DELAY	"animationDelay"
#macro REFLEX_PROPERTY_PADDING			"padding"
#macro REFLEX_PROPERTY_MARGIN			"margin"
#macro REFLEX_PROPERTY_BORDER			"border"
#macro REFLEX_PROPERTY_BACKGROUNDCOLOR	"backgroundColor"
#macro REFLEX_PROPERTY_BACKGROUND_IMAGE	"backgroundImage"
#macro REFLEX_PROPERTY_BORDERCOLOR		"borderColor"
#macro REFLEX_PROPERTY_STYLES			"styles"
#macro REFLEX_PROPERTY_HOT_VERB			"hotVerb"

// Dynamic Styles
#macro REFLEX_STYLE_HOVER				"hover"
#macro REFLEX_STYLE_FOCUS				"focus"

// Events
#macro REFLEX_EVENT_ON_CLICK		"onClick"
#macro REFLEX_EVENT_ON_DRAW			"onDraw"
#macro REFLEX_EVENT_ON_FOCUS		"onFocus"
#macro REFLEX_EVENT_ON_FOCUS_OUT	"onFocusOut"
#macro REFLEX_EVENT_ON_LAYOUT		"onLayout"
#macro REFLEX_EVENT_ON_LOAD			"onLoad"
#macro REFLEX_EVENT_MOUSE_ENTER		"onMouseEnter"
#macro REFLEX_EVENT_MOUSE_EXIT		"onMouseExit"
#macro REFLEX_EVENT_MOUSE_OVER		"onMouseOver"
#macro REFLEX_EVENT_ON_STEP			"onStep"
#macro REFLEX_EVENT_ON_UPDATE		"onUpdate"
#macro REFLEX_EVENT_UNLOAD			"onUnload"

enum ReflexLayout {
	block,
	inline
}

enum ReflexProperty {
	inherit = -32500,
	off = -32499,
	auto = -32498,
	expand = -32497
}

enum ReflexPosition {
	relative,
	absolute
}

enum ReflexAnimationType {
	OneShot,
	Loop,
	PingPong
}

enum ReflexOverflow {
	Constrain,
	Visible
}