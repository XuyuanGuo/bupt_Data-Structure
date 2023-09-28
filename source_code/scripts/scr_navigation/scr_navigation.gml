function init_pair(_a, _b) constructor{
	dis=_a;
	_id=_b;
}


function dijkstra(_start, _end){
	var dis = [], pre = [];
	for (var i=NAVI_POINT_N+1;i>-1;i--){
		pre[i] = -1;
		dis[i] = -1;
	}
	var heap =new heap_init(NAVI_POINT_N+1);
	//将起点的入口放入堆中
	for (var i=1;i<=global.entrance[_start][0];i++){
		dis[global.entrance[_start][i]]=0;
		heap_push(heap, new init_pair(0, global.entrance[_start][i]));
	}
	while(heap.idx!=0){
		var t = heap_top(heap);
		heap_pop(heap);
		if (dis[t._id]<t.dis) continue;
		//更新并保存两个建筑之间的最短距离
		if (global.navipoint[t._id].building!=-1){
			global.mappoint_dis[_start][global.navipoint[t._id].building]=min(global.mappoint_dis[_start][global.navipoint[t._id].building], dis[t._id]);
			global.mappoint_dis[global.navipoint[t._id].building][_start]=global.mappoint_dis[_start][global.navipoint[t._id].building];
		}
		//找到最短路，生成路径并结束搜索
		if (global.navipoint[t._id].building==_end){
			var l = 0;
			var path = [];
			while (t._id!=-1){
				path[l++]=t._id;
				t._id=pre[t._id];
			}
			while (l) global.navi_path[++global.navi_path[0]] = path[--l];
			return;
		}
		//将堆顶节点向下一步扩展
		for (var i=0;i<global.navipoint[t._id].num;i++){
			var j = global.navipoint[t._id].e[i];
			if (dis[j]==-1 || global.navipoint[t._id].d[i]+dis[t._id]<dis[j]){
				dis[j] = global.navipoint[t._id].d[i]+dis[t._id];
				pre[j] = t._id;
				heap_push(heap, new init_pair(dis[j], j));
			}
		}
	}
	return;
}

function init_TSP_node(_a, _b, _c, _d) constructor{
	cost = _a; //当前花费
	low_bound = _b; //最小上界
	dis=_a+_b; //堆的比较指标，当前花费+最小上界最小的节点到堆顶
	path = _c; //路径
	now = _d; //当前所处建筑
}

function TSP(building_list){
	var edge = [];
	var l = building_list[0];
	if (l==2) return [2, building_list[1], building_list[2]];
	var low_edge = []; //所有建筑的最小出边
	memset(low_edge, l, INT_MAX);
	memset2(edge, l, l, INT_MAX);
	//离散化
	for (var i=1; i<=l; i++){
		for (var j=1;j<=l;j++){
			if (i!=j){
				if (global.mappoint_dis[building_list[i]][building_list[j]]==INT_MAX) dijkstra(building_list[i], building_list[j]);
				edge[i][j] = global.mappoint_dis[building_list[i]][building_list[j]];
				edge[j][i] = edge[i][j];
				if (edge[i][j]<low_edge[i]) low_edge[i] = edge[i][j];
			}
		}
	}
	//初始化个信息
	var heap =new heap_init(factorial(l-1)+1);
	var basic_low_bound = 0; //最小上界，为所有点的最小邻边之和
	var best = INT_MAX; //最短途径距离
	var best_path = [1, 1]; //最优途径顺序
	for (var i=1;i<=l;i++){
		basic_low_bound+=low_edge[i];
	}
	heap_push(heap, new init_TSP_node(0, basic_low_bound, [1,1,0,0,0,0,0,0,0,0,0,0], 1));
	while(heap.idx!=0){
		var t = heap_top(heap);
		heap_pop(heap);
		//当前点花费+最小上界大于最短途径距离，无法得到更优解，搜索结束
		if (t.dis+low_edge[1]>=best){
			var an = [l];
			an[l] = 0;
			for (var i=1;i<=l;i++) an[best_path[i]] = building_list[i];
			return an;
		}
		//搜索到终点
		if (t.path[0]==l){
			if (t.cost+edge[t.now][1]<best){
				best = t.cost+edge[t.now][1];
				memcpy(t.path, best_path, l);
			}
			continue;
		}
		//从当前点往下搜索
		for (var i=2;i<=l;i++){
			if (t.path[i]==0){
				var newpath = [];
				memcpy(t.path, newpath, l);
				newpath[i] = ++newpath[0];
				heap_push(heap, new init_TSP_node(t.cost+edge[t.now][i], t.low_bound-low_edge[t.now], newpath, i));
			}
		}
	}
}