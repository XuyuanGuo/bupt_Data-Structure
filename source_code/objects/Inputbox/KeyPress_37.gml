/// @description Insert description here
// You can write your code in this editor
if (isinput == 1 && inputx>0){
	inputx--;
	str3 = string_copy(keyboard_string, string_length(keyboard_string), 1) + str3;
	keyboard_string = string_copy(keyboard_string, 1, string_length(keyboard_string)-1);
}