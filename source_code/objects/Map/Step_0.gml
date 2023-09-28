switch (state){
	case 0:
		refresh_mappoint();
		state = 1;
	break;
	case 1:
	//当前处于地图界面时，检测键盘输入
	if (depth==get_floor()){
		if (keyboard_check(ord("J"))){ //地图放大
			if (scale<4){
				left+=16.8/(scale*scale);
				top+=10.5/(scale*scale);
				scale+=0.02;
			}
		}else if(keyboard_check(ord("K"))){ //地图缩小
			if (scale>0.02){
				if (left-16.8/(scale*scale)>0){
					left-=16.8/(scale*scale);
					if (left-16.8/(scale*scale)>0 && left-16.8/(scale*scale)+WINDOW_WIDTH/scale>map_w) left-=16.8/(scale*scale);
				}
				if (top-10.5/(scale*scale)>0){
					top-=10.5/(scale*scale);
					if (top-10.5/(scale*scale)>0 && top-10.5/(scale*scale)+WINDOW_HEIGHT/scale>map_h) top-=10.5/(scale*scale);
				}
				if (left+WINDOW_WIDTH/(scale-0.02)<map_w && top+WINDOW_HEIGHT/(scale-0.02)<map_h){
					scale-=0.02;
				}
			}
		}else{
			if (keyboard_check(ord("A"))){
				left = clamp(left-20, 0, map_w-WINDOW_WIDTH/scale);
			}else if(keyboard_check(ord("D"))){
				left = clamp(left+20, 0, map_w-WINDOW_WIDTH/scale);
			}
			if (keyboard_check(ord("S"))){
				top=min(top+20, map_h-WINDOW_HEIGHT/scale);
			}else if(keyboard_check(ord("W"))){
				top=max(0, top-20);
			}
		}
		refresh_mappoint();
	}
	break;
}