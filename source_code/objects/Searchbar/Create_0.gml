w = 1000;
h = 1000;
h_limit = 0;
y_st = 230;
image_xscale = 1000;
image_yscale = 1000;
depth = -4;
state = 0;
father = noone;

str = "";
len = 0;
textlabel = [];
idlist = [];
chose = -1;

len = 0;
delta_h = 0;
e = [];
e[0] = instance_create_depth(x+w-60, y+y_st, depth-1, Scrollbar);
e[0].xx=x+w-60;
e[0].father = self;
e[0].image_yscale = 0.6;
e[0].h_range = h-350;

e[1] = instance_create_button(x+250, y+900, 200, 60, 0.8, 27, "查看信息", self);
e[2] = instance_create_textlabel(x+65, y+190, 80, 30, 0.7, 0, "时间");
e[3] = instance_create_textlabel(x+310, y+190, 80, 30, 0.7, 0, "类型");
e[4] = instance_create_textlabel(x+615, y+190, 80, 30, 0.7, 0, "排序方式");
e[5] = instance_create_button(x+550, y+900, 200, 60, 0.8, 9, "返回", self);

searchbutton = instance_create_depth(x+w-120, y+80, depth-3, Search);
searchbutton.father = self;
inputbox = instance_create_inputbox(x+62, y+90, 800, 60, 0.8);
inputbox.father = self;
chooselist = [];
chooselist[0] = instance_create_chooselist(x+130, y+170, 160, 45, 0.7, 3, self, ["不限","一周内","一个月内"]);
chooselist[1] = instance_create_chooselist(x+380, y+170, 170, 45, 0.7, 5, self, ["考试","课程","集体活动","个人活动","临时事务"]);
chooselist[1].tp = 2;
chooselist[2] = instance_create_chooselist(x+705, y+170, 130, 45, 0.7, 2, self, ["按时间","按类型"]);
chooselist[3] = instance_create_chooselist(x+850, y+170, 92, 45, 0.7, 2, self, ["正序","倒序"]);
surf = surface_create(w-120, h_limit + 6000);

function go_search(){
	if (inputbox.str2!=""){
		var flag = 0;
		for (var i = 0; i<5; i++) if (chooselist[1].choselist[i]==1) flag=1;
		for (var i = 0; i<len; i++) instance_destroy(textlabel[i]);
		var linklist = global.search_hash.get(inputbox.str2);
		if (linklist == noone || linklist.len==0){
			show_message("搜索结果为空");
			len = 0;
			return;
		}
		//show_message(linklist.len);
		var i=0; j=0;
		while (linklist.next!=noone){
			linklist = linklist.next;
			var tm = time_to_int2(key_to_schedule(linklist.data));
			if (chooselist[0].chose>=1){
				if (tm<time_to_int(new init_time(global.week, global.day, global.hour))) continue;
				if (chooselist[0].chose==2 && tm>=min(16*7*24+7*24+24, time_to_int(new init_time(global.week+4, global.day, global.hour)))) continue;
				if (chooselist[0].chose==1 && tm>=min(16*7*24+7*24+24, time_to_int(new init_time(global.week+1, global.day, global.hour)))) continue;
			}
			if (flag){
				if (linklist.data>2*course_N+activity_N){
					if (chooselist[1].choselist[4]!=1) continue;
				}else if(linklist.data>=2*course_N){
					if (key_to_schedule(linklist.data).tp==3 && chooselist[1].choselist[3]!=1) continue;
					if (key_to_schedule(linklist.data).tp==2 && chooselist[1].choselist[2]!=1) continue;
				}else if(linklist.data>=course_N){
					if (chooselist[1].choselist[1]!=1) continue;
				}else{
					if (chooselist[1].choselist[0]!=1) continue;
				}
			}
			idlist[i++] = new init_pair(time_to_int2(key_to_schedule(linklist.data)), linklist.data);
		}
		len = i;
		if (len == 0){
			show_message("搜索结果为空");
			return;
		}
		if (chooselist[2].chose==0){
			if (chooselist[3].chose==0){
				qsort(idlist, 0, len-1, 2);
			}else{
				qsort(idlist, 0, len-1, 3);
			}
		}else{
			if (chooselist[3].chose==0){
				qsort(idlist, 0, len-1, 4);
			}else{
				qsort(idlist, 0, len-1, 5);
			}
		}
		//for (var i=0;i<len;i++) show_message(key_to_schedule(idlist[i]._id)._name);
		var _str = [], l=0;
		_str[len] = "";
		for (var i=0, j=0;i<len;i++){
			var a = key_to_schedule(idlist[i]._id);
			textlabel[i] = instance_create_textlabel(x+48, y+230+j, w-140, 60, 0.8, 0, a._name + " " + time_to_text(a)/* + string(time_to_int2(a))*/);
			textlabel[i].father = self;
			textlabel[i].num = idlist[i]._id;
			textlabel[i].yy = j;
			textlabel[i].num2 = a.tp;
			textlabel[i].tp = 11;
			textlabel[i].image_yscale=string_height_ext(textlabel[i].str,60,900);
			//show_message(textlabel[i].str);
			_str[l++] = textlabel[i].str;
			j+=string_height_ext(textlabel[i].str,60,900)+8;
		}
		log_create_search(_str, inputbox.str2, l);
		h_limit = j-620;//min(j - 620, 5000);
		if (h_limit>0) e[0].visible = 1;
		else e[0].visible = 0;
	}else{
	}
	str = inputbox.str2;
}

function refresh(){
	if (str!=""){
		chose = -1;
		var flag = 0;
		for (var i = 0; i<5; i++) if (chooselist[1].choselist[i]==1) flag=1;
		for (var i = 0; i<len; i++) instance_destroy(textlabel[i]);
		var linklist = global.search_hash.get(str);
		if (linklist == noone || linklist.len==0){
			if (surface_exists(surf))surface_free(surf);
			len = 0;
			return;
		}
		//show_message(linklist.len);
		var i=0; j=0;
		while (linklist.next!=noone){
			linklist = linklist.next;
			var tm = time_to_int2(key_to_schedule(linklist.data));
			if (chooselist[0].chose>=1){
				if (tm<time_to_int(new init_time(global.week, global.day, global.hour))) continue;
				if (chooselist[0].chose==2 && tm>=min(16*7*24+7*24+24, time_to_int(new init_time(global.week+4, global.day, global.hour)))) continue;
				if (chooselist[0].chose==1 && tm>=min(16*7*24+7*24+24, time_to_int(new init_time(global.week+1, global.day, global.hour)))) continue;
			}
			if (flag){
				if (linklist.data>2*course_N+activity_N){
					if (chooselist[1].choselist[4]!=1) continue;
				}else if(linklist.data>=2*course_N){
					if (key_to_schedule(linklist.data).tp==3 && chooselist[1].choselist[3]!=1) continue;
					if (key_to_schedule(linklist.data).tp==2 && chooselist[1].choselist[2]!=1) continue;
				}else if(linklist.data>=course_N){
					if (chooselist[1].choselist[1]!=1) continue;
				}else{
					if (chooselist[1].choselist[0]!=1) continue;
				}
			}
			idlist[i++] = new init_pair(time_to_int2(key_to_schedule(linklist.data)), linklist.data);
		}
		len = i;
		if (len == 0){
			return;
		}
		if (chooselist[2].chose==0){
			if (chooselist[3].chose==0){
				qsort(idlist, 0, len-1, 2);
			}else{
				qsort(idlist, 0, len-1, 3);
			}
		}else{
			if (chooselist[3].chose==0){
				qsort(idlist, 0, len-1, 4);
			}else{
				qsort(idlist, 0, len-1, 5);
			}
		}
		//for (var i=0;i<len;i++) show_message(key_to_schedule(idlist[i]._id)._name);
		for (var i=0, j=0;i<len;i++){
			var a = key_to_schedule(idlist[i]._id);
			textlabel[i] = instance_create_textlabel(x+48, y+230+j, w-140, 60, 0.8, 0, a._name + " " + time_to_text(a));
			textlabel[i].father = self;
			textlabel[i].num = i;
			textlabel[i].yy = j;
			textlabel[i].num2 = a.tp;
			textlabel[i].tp = 11;
			textlabel[i].image_yscale=string_height_ext(textlabel[i].str,60,900);
			j+=string_height_ext(textlabel[i].str,60,900)+8;
		}
		h_limit = j-620;//min(j - 620, 5000);
		if (h_limit>0) e[0].visible = 1;
		else e[0].visible = 0;
	}else{
	}
	for (var i=0, j = 0;i<len;i++){
		textlabel[i].y=y+235+j-delta_h;
		textlabel[i].yy=j;
		j+=string_height_ext(textlabel[i].str, 60, 900);
	}
}

function destroy(){
	for (var i = 0; i<len; i++) instance_destroy(textlabel[i]);
	for (var i = 0; i<6; i++) instance_destroy(e[i]);
	for (var i = 0; i<4; i++) chooselist[i].destroy();
	instance_destroy(inputbox);
	instance_destroy(searchbutton);
	surface_free(surf);
	close_window();
	instance_destroy();
}