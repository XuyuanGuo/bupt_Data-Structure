switch (tp){
	//单选框
	case 3:
		if (active && mouse_y>father.y+father.h && mouse_y<father.y+father.h*min(6,father.len+1)){
			father.state = 3;
			father.chose = num;
		}
	break;
	//日程查询界面的选择框
	case 12:
		if (active && mouse_y>father.y+father.h && mouse_y<father.y+father.h*min(6,father.len+1)){
			if (!outline){
				father.choselist[num] = 1;
				outline = 1;
			}else{
				father.choselist[num] = 0;
				outline = 0;
			}
		}
	break;
	case 1:
		father.chose = num;
	break;
	case 4:
		if (active && global.in_graph && depth<get_floor() && mouse_x>230 && mouse_y<1000 && mouse_y>200 && num && !father.e[1].ready && !father.e[2].ready){
			open_window(-9);
			friend = instance_create_depth(840-200, 525-480, -9, CourseInfobar);
			friend.father = self;
			friend.chose = num;
		}
	break;
	case 7:
		if (active && global.in_graph && depth<get_floor() && mouse_x>230 && mouse_y<1000 && mouse_y>200 && num && !father.e[1].ready && !father.e[2].ready){
			open_window(-9);
			if (num >= temp_N){
				friend = instance_create_depth(840-300, 525-400, -9, TempstuffInfobar);
				friend.father = self;
				friend.filename = str;
				friend.state = 0;
				friend.checklist[0].refresh();
				friend.checklist[1].refresh();
			}else{
				friend = instance_create_depth(840-200, 525-440, -9, ActivityInfobar);
				friend.father = self;
				friend.chose = num;
			}
		}
	break;
	case 8:
		if (active && global.in_graph && depth<get_floor() && mouse_x>230 && mouse_y<1000 && mouse_y>200 && num && !father.e[1].ready && !father.e[2].ready){
			open_window(-9);
			if (mouse_y>y+image_yscale/2){
				if (num2 >= temp_N){
					friend = instance_create_depth(840-300, 525-400, -9, TempstuffInfobar);
					friend.father = self;
					friend.filename = str;
					friend.state = 0;
					friend.checklist[0].refresh();
					friend.checklist[1].refresh();
				}else{
					friend = instance_create_depth(840-200, 525-440, -9, ActivityInfobar);
					friend.father = self;
					friend.chose = num2;
				}
			}else{
				friend = instance_create_depth(840-200, 525-480, -9, CourseInfobar);
				friend.father = self;
				friend.chose = num;
			}
		}
	break;
	case 5: case 11:
		if (active){
			if (tp!=11 || (y<father.y+father.h-160&&y>father.y+240-2*string_height_ext(str,60,900))){
				for (var i=0; i<father.len; i++){
					if (father.textlabel[i].num!=num) father.textlabel[i].outline = 0;
				}
				if (father.chose != num){
					father.chose = num;
					if (instance_exists(Logbar)) father.father.choose_list_change(father);
					outline = 1;
				}else{
					father.chose=-1;
					outline = 0;
				}
			}
		}
	break;
	//临时事务左侧单选框
	case 9:
		if (active){
			for (var i=0; i<father.len; i++){
				if (father.textlabel[i].num!=num) father.textlabel[i].outline = 0;
			}
			if (father.chose != num){
				father.chose = num;
				outline = 1;
				father.father.filename = str;
				father.father.checklist[1].state = 3;
			}else{
				father.chose = -1;
				outline = 0;
				father.father.filename = "";
				father.father.checklist[1].state = 3;
				father.father.state = 0;
			}
		}
	break;
	//临时事务右侧单选框
	case 10:
		if (active){
			for (var i=0; i<father.len; i++){
				if (father.textlabel[i].num!=num) father.textlabel[i].outline = 0;
			}
			if (father.chose != num){
				father.chose = num;
				outline = 1;
				father.father.state = 0;
			}else{
				father.chose = -1;
				outline = 0;
				father.father.state = 0;
			}
		}
	break;
	case 6:
		if (active){
			outline = !outline;
		}
	break;
}