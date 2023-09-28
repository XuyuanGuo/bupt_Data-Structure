function heap_init(_size) constructor{
	data = [];
	data[_size] = noone;
	idx = 0; //目前堆中的元素个数
	cmp_tp = 0;
	function heap_push(_a){ //向堆中添加元素
	    data[++idx]=_a;
		heap_up(self, idx);
	} 
	function heap_top(){//访问堆顶元素
		return data[1];
	} 
	function heap_pop(){//删除堆顶元素
		if(idx==0) return 0;
		heap_swap(self, 1, idx);
	    idx--;
		heap_down(self, 1);
	    return 1;
	} 
	return;
};

function heap_cmp(_h, _a, _b, tp){
	if (_h.data[_a].dis<_h.data[_b].dis) return -1;
	if (_h.data[_a].dis>_h.data[_b].dis) return 1;
	return 0;
}

//交换堆中元素
function heap_swap(_h, _a, _b){
    var temp=_h.data[_a];
    _h.data[_a]=_h.data[_b];
    _h.data[_b]=temp;
}

//向上更新
function heap_up(_h, _x){
	var t = _x;
    while(t!=1 && heap_cmp(_h, _x, _x/2)<0){
        heap_swap(_h, t, t/2);
        t=t/2;
    }
}

//向下更新
function heap_down(_h, _x){
    var t=_x;
    if(2*_x+1<=_h.idx&&heap_cmp(_h, t, 2*_x+1)>0&&heap_cmp(_h, 2*_x, 2*_x+1)>0)
        t=2*_x+1;
	else if(2*_x<=_h.idx&&heap_cmp(_h, t, 2*_x)>0)
        t=2*_x;
    if(t!=_x){
        heap_swap(_h, _x, t);
        heap_down(_h, t);
    }
}

//向堆中添加元素
function heap_push(_h, _a){
    _h.data[++_h.idx]=_a;
    heap_up(_h, _h.idx);
	return;
}

//访问堆顶元素
function heap_top(_h){
    return _h.data[1];
}

//删除堆顶元素
function heap_pop(_h){
    if(_h.idx==0) return 0;
    heap_swap(_h, 1, _h.idx);
    _h.idx--;
    heap_down(_h, 1);
    return 1;
}