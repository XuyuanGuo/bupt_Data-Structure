//tp==0 从小到大
//tp==1 从大到小
function cmp(_a, _b, tp){
	switch (tp){
		case 0: 
			if (_a<_b) return -1;
			if (_a>_b) return 1;
			return 0;
		break;
		case 1: 
			if (_a<_b) return 1;
			if (_a>_b) return -1;
			return 0;
		break;
		case 2: 
			if (_a.dis<_b.dis) return -1;
			return (_a.dis>_b.dis);
		break;
		case 3:
			if (_a.dis>_b.dis) return -1;
			return (_a.dis<_b.dis);
		break;
		case 4:
			if (_a._id<_b._id) return -1;
			return (_a._id>_b._id);
		break;
		case 5:
			if (_a._id>_b._id) return -1;
			return (_a._id<_b._id);
		break;
	}
}
//快速排序
//参数 1 list 需要排序的列表 2 real 表的左边界 3 real 表的右边界 4 real 排序类型
function qsort(idList, l, r, cmp_tp){
    if(l>=r)
        return;
    var i=l-1, j=r+1;
    var _x=idList[(l+r)/2];
    while(i<j)
    {
		i++;
        while(cmp(idList[i],_x,cmp_tp)==-1){
			i++;
		}
		j--;
        while(cmp(idList[j],_x,cmp_tp)==1){
			j--;
		}
        if(i<j){
			var t = idList[i];
			idList[i] = idList[j];
			idList[j] = t;
		}
    }
    qsort(idList,l,j,cmp_tp);
    qsort(idList,j+1,r,cmp_tp);
}