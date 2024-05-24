#macro REFLEX_GLOBAL			global.__reflex
#macro REFLEX_ROOTS				REFLEX_GLOBAL.roots
#macro REFLEX_STYLESHEET		REFLEX_GLOBAL.stylesheet
#macro REFLEX_EMPTY				REFLEX_GLOBAL.emptyStruct
#macro REFLEX_STATE				REFLEX_GLOBAL.stateManager
#macro REFLEX_INPUT				REFLEX_GLOBAL.inputManager
#macro REFLEX_COLORS			REFLEX_GLOBAL.colors
#macro REFLEX_MOUSE_DEVICE		REFLEX_GLOBAL.mouseDevice
#macro REFLEX_ANIMATIONS		REFLEX_GLOBAL.animations

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

// Styles
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
	auto = -32498
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