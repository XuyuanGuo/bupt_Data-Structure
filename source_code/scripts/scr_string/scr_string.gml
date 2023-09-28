//输入一个字符串，每隔一定数量的字符插入换行、
//参数1：string 输入的字符串  参数2：real 换行宽度
function string_endline(_str, w){
	var p = w;
	while (p<string_length(_str)){
		_str = string_insert("\n", _str, p);
		p+=w;
	}
	return _str;
}

//输入一个字符串，删除超过一定长度的部分
//参数1 string 输入的字符串
function string_cut(_str){
	if (string_length(_str)>9){
		return string_copy(_str,1,9) + "…";
	}
	return _str;
}