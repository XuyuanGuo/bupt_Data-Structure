// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
mylist = {
	length: 0,
	data: []
};
function init_list(_a) constructor
{
    length = _a;
	var i = _a-1;
	repeat(_a)
	{
		data[i] = 0;
		i -= 1;
	}
}

function memset(_a, size, _v){
	for (var i=size;i>-1;i--){
		_a[i]=_v;
	}
}

function memset2(_a, size_x, size_y, _v){
	_a[size_x] = [];
	for (var i=0;i<=size_x;i++){
		_a[i] = [];
		for (var j=size_y;j>-1;j--) _a[i][j] = _v;
	}
}

function memcpy(_a, _b, size){
	for (var i=0;i<=size;i++){
		_b[i]=_a[i];
	}
}
