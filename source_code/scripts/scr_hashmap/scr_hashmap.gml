#macro hash_N 12289
#macro hash_N2 211
#macro hash_prime 13

function get_hash(a, n){//根据a的不同类型选择对应算法计算哈希值
	if (typeof(a)=="number") return 1;
	var length = string_length(a);
    var temp = 1;
    for(var i=1;i<=length;i++){
        temp=(temp*hash_prime+ord(string_char_at(a, i))) mod n;
	}
    return temp mod n;
}

//哈希表为hashNode数组
function init_hashNode(_a, _b, _c) constructor{
	key = _a;
	data = _b;
    next = _c;
};

function init_hashmap(_size) constructor{
	node = []; //存放哈希节点的数组
	//初始化
	size = _size;
	for (var i=_size;i>=0;i--) 
		node[i] = noone;
	function set(_a,_v){
		var t = get_hash(_a, size);
		if (node[t]==noone){
			node[t] = new init_hashNode(_a,_v,noone);
			return _v;
		}
		if (node[t].key==_a){
			node[t].data = _v;
			return node[t];
		}
		var cur = node[t];
		while (cur.next!=noone){
			if (cur.next.key==_a){
				cur.next.data = _v;
				return _v;
			}
			cur = cur.next;
		}
		cur.next = new init_hashNode(_a,_v,noone);
		return _v;
	}
	function get(_a){
		var t = get_hash(_a, size);
		if (node[t]!=noone){
			var cur = node[t];
			while (cur!=noone){
				if (cur.key==_a){
					return cur.data;
				}
				cur = cur.next;
			}
		}
		return noone;
	}
	function remove(_a){
		var t = get_hash(_a, size);
		if (node[t]==noone){
			return;
		}
		if (node[t].key==_a){
			node[t]=node[t].next;
			return;
		}
		var cur = node[t].next;
		var pre = node[t];
		while (cur!=noone){
			if (cur.key==_a){
				pre.next = cur.next;
				return;
			}
			cur=cur.next;
			pre=pre.next;
		}
	}
}


