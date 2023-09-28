switch (state){
	//刷新信息状态
	case 0:
		if (filename!="" && checklist[1].chose!=-1){
			var p = read_tempstuff_info(filename_to_time(filename))[checklist[1].chose+1];
			global.tempstuff = tempstuff_copy(p);
		}else{
			global.tempstuff = new init_tempstuff();
		}
		inputbox[0].isinput = 0;
		inputbox[1].isinput = 0;
		chooselist[0].inputbox.str2 = global.tempstuff._name;
		chooselist[1].chose = global.tempstuff.isalarm;
		chooselist[2].chose = global.tempstuff.week - 1;
		chooselist[3].chose = global.tempstuff.day;
		chooselist[4].chose = global.tempstuff.building;
		inputbox[0].str2 = string(global.tempstuff.time);
		inputbox[1].str2 = string(global.tempstuff.classroom);
		state = 1;
	break;
	//读写信息状态
	case 1:
		global.tempstuff._name = chooselist[0].inputbox.str2;
		if (inputbox[0].str2!="") global.tempstuff.time = clamp(real(inputbox[0].str2), 6, 21);
		if (inputbox[1].str2!="") global.tempstuff.classroom = real(inputbox[1].str2);
		global.tempstuff.week = chooselist[2].chose + 1;
		global.tempstuff.day = chooselist[3].chose;
		global.tempstuff.building = chooselist[4].chose;
		global.tempstuff.isalarm = chooselist[1].chose;
		global.tempstuff.edweek = chooselist[2].chose + 1;
		if (global.tempstuff.building<5){
			textlabel[2].visible = 1;
			inputbox[1].visible = 1;
		}else{
			textlabel[2].visible = 0;
			inputbox[1].visible = 0;
		}
	break;
	//销毁状态
	case 2:
		for (var i=0; i<6; i++) instance_destroy(button[i]);
		for (var i=0; i<8; i++) instance_destroy(textlabel[i]);
		for (var i=0; i<2; i++) instance_destroy(inputbox[i]);
		for (var i=0; i<5; i++) chooselist[i].destroy();
		checklist[0].destroy();
		checklist[1].destroy();
		close_window();
		instance_destroy();
	break;
}