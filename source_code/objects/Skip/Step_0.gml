image_xscale=scale;
image_yscale=scale;
switch (state){
	case 0:
		scale = 1;
	break;
	case 1:
		scale = 0.95;
	break;
	case 2:
		scale = 1;
		state = 0;
	break;
	case 3:
		scale = 1;
		var s = "";
		s = get_string("请输入要向后跳转的天数","");
		if (s!=""){
			s = string_digits(s);
			if (s!=""){
				s=real(s);
				if (s!=0){
					if (global.week + floor((s+global.day)/7)>16) {
						show_message("时间跳转过远");
					}else{
						global.week = global.week + floor((s+global.day-1)/7);
						global.day = (global.day + s -1) mod 7;
						global.hour = 23;
						global.time = 59;
					}
				}
			}
		}
		state = 0;
	break;
}