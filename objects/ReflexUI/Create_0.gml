/// @description Insert description here
// You can write your code in this editor

if(instance_number(ReflexUI) > 1)
	show_error("Only a single instance of ReflexEngine should be running.", false);
	
components = {};