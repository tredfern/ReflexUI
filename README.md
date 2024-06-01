# ReflexUI
A Reactive UI Library for GameMaker Studio 2

## Overview
ReflexUI is a responsive UI library for GameMaker Studio 2 that uses a [Box Model](https://www.w3schools.com/css/css_boxmodel.asp) layout for positioning and drawing components. Components are organized into a UI Tree, similar to React and promotes a model where a series of lightweight components can be utilized together to quickly create a UI system for you game.

Because ReflexUI is managing the layout of components, this allows it to assist in enabling intelligent input support for gamepads, keyboards, or mouse without working through lots of implementation details within the code.

The great thing about ReflexUI is that you don't need to remember and implement a dozen different functions or instantiate a bunch of objects to make it work. Behind the scenes it will convert data to the appropriate objects for rendering. -> NOTE: For robust functionality, it will take digging in, but getting started should be easy.

*Dependencies*: Note that this library contains two external dependencies that are included in it's release. 
* [ScribbleJr](https://www.jujuadams.com/ScribbleJunior/#/1.3/Scribblejr) - for text rendering support
* [Input](https://offalynne.github.io/Input/#/6.2/) - for gamepad and input support

### Installation
1. Download the latest release .yymps
2. Import the package into your GameMaker Studio 2 project
3. Add the ReflexUI folder - **required**
4. *If you have NOT installed ScribbleJr and/or Input in your project*
    1. Add the "Included Files" folder -> this contains licenses for ScribbleJr, Input, as well as some key supporting files for the Input library
    1. Add the ScribbleJr and Input folders
5. *OPTIONAL* Add the ReflexUI - Demo folder for example components

## Quick Start
1. Create an object and add a create event 
2. Within the create event add
```
Reflex(
    new ReflexBlock({ backgroundColor: c_ltgray }, [
        "I'm some text in a block",
        new ReflexButton({ 
            margin: 10,
            padding: 15, 
            border: 1,
            borderColor: c_red,
            halign: fa_right,
            backgroundColor: c_green,
            text: "Push Me", 
            onClick: game_end })
    ])
);
```
1. This will render a full light gray bar across the top of the screen.
2. Some text.
3. A button that will be aligned to the right side of the screen
4. Clicking the button will close the game. 

Strings are automatically converted into Text Elements, but they will only have formatting they have inheritted from their parent. Things like the font or color. 

To do some more interesting things with the text we can convert it into a text element and applying styling.
```
new ReflexText({ text: "I'm some text in a block", valign: fa_middle, margin: 10 })
```


## Creating Components
ReflexUI comes with some simple components out of the box to enable some initial development, but to actually design your UI you will need to create your own components. Your components can render out subcomponents to create a whole tree of UI elements that Reflex will leverage to layout the experience.

Let's design a simple HUD for the top of the screen on a dungeon crawler game. You want to show the gold, current XP, Health, and what level we are on.

Let's start with something static
```
function CrawlerHUD() : ReflexComponent() constructor {
    static render = function() {
        return [
            new ReflexText("Gold 1234"),
            new ReflexProgressBar()
            new ReflexProgressBar(),
            new ReflexText("Level 12") 
        ]
    }
}

Reflex(new CrawlerHUD());
```


## Configuration
ReflexUI is designed to start without any additional work or configuration on your part. Importing the library into your project and you can use the functionality of ReflexUI.

The default configurations for the library are located in ReflexConfiguration. You are free to make changes to these as you like. **TIP:** This is a great file to look at for the various layout properties available to components.

A better way to configure Reflex is to provide your own user configuration. This ensures that your settings take precedence and keeps your code separate from the library code. This makes updating the library easier as it should keep your custom and project specific settings separate from the ones that power the library.

```
ReflexUserConfiguration(function() {
    reflexColors({ ... });          // Set up any color schemes 
    reflexAnimations({ ... });      // Animations for your components
    reflexInputVerbs({ ... });      // Define which verbs to use for input
    reflexStyleSheet({ ... });      // Define styles for components
})
```
*ReflexUserConfiguration allows you to not worry about execution order of scripts while configuring ReflexUI.*

### Stylesheets

The first and most important option for configura

There are several configuration options available to for setting up the API. This code can be located in your own files. You do not need to adjust anything within the Library folder itself. However, if you are interested in making some low-level configuration changes you can take a look at the ReflexConfiguration script file in the root folder. That contains the basic configurations 

## Layout and Display Properties



## Philosophy

