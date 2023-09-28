if (active){
	if (state == 0 && depth<get_floor()){
		open_window(depth);
		state = 1;
	}else if (state == 2){
		if (tp == 1) chose = -1;
		state =3;
	}
}
event_inherited();
