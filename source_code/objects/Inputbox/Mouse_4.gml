/// @description Insert description here
// You can write your code in this editor
if (depth<get_floor()){
	with(Inputbox) isinput = 0;
	isinput = 1;
	//确定光标位置
	inputx = string_length(str2);
	for (var i = 1; i<=inputx; i++){
		if (str_width[i]+x>=mouse_x){
			if (i!=0) str3 = string_copy(str2, i, inputx - i + 2);
			else str3 = str2;
			inputx = i-1;
			break;
		}
	}
	if (inputx = string_length(str2)) str3 = "";
	if (str2!="" )keyboard_string = string_copy(str2, 1, inputx);
	else keyboard_string = "";
}