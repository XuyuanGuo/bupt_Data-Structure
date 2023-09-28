

function init_linklist(_a, _b, _c) constructor
{
	pre = _a; //前一个结点
	data = _b; //结点值
	next = _c; //后一个结点
}

function init_linklistHead() constructor{
	next = noone; //头结点的下一个结点
	len = 0; //链表内元素个数
	
	function insert_norep(_v){ //插入值为_v的结点并在插入时去重
		if (next==noone){
			next = new init_linklist(self, _v, noone);
			len++;
			return;
		}
		var cur = next;
		if (cur.data == _v) return;
		while (cur.next!=noone){
			cur = cur.next;
			if (cur.data == _v) return;
		}
		cur.next = new init_linklist(cur, _v, noone);
		len++;
	}
	function insert(_v){ //头插
		var cur = new init_linklist(self, _v, next);
		next = cur;
		len++;
	}
	function remove(_v){ //移除值为_v的节点
		var pre = self, cur = next;
		while (cur!=noone){
			if (cur.data==_v){
				pre.next = cur.next;
				if (cur.next!=noone){
					cur.next.pre = pre;
				}
				len--;
				return;
			}
			pre = pre.next;
			cur = cur.next;
		}
	}
}