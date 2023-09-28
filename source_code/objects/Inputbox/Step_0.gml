/// @description Insert description here
// You can write your code in this editor
if (isinput==1){
	if (string_width(keyboard_string+str3)*wordsize<=w){
		if (numberonly == 1) str2 = string_digits(keyboard_string+str3);
		else if (letteronly == 1) str2 = string_lettersdigits(keyboard_string+str3);
		else str2 = keyboard_string+str3;
		inputx = string_length(keyboard_string);
	}else{
		if (numberonly == 1) keyboard_string = string_digits(str2);
		else if (letteronly == 1) keyboard_string = string_lettersdigits(str2);
		else keyboard_string = str2;
	}
	if (numberonly == 1) keyboard_string = string_digits(keyboard_string);
	if (letteronly == 1) keyboard_string = string_lettersdigits(keyboard_string);
}
for (var i=1;i<=string_length(str2);i++){
	str_width[i]=string_width(string_copy(str2, 1, i))*wordsize;
}