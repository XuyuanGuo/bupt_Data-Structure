if (isinput == 1 && inputx<string_length(str2)){
	inputx++;
	keyboard_string = keyboard_string + string_copy(str3, 1, 1);
	str3 = string_copy(str3, 2, string_length(str3)-1);
}