switch (state){
	case 0:
		h_limit = len*70 - 580;
		if (h_limit<=0) e.visible = 0;
		state = 1;
	break;
	case 1:
		if (!surface_exists(surf)){
			surf = surface_create(w-120, h_limit + 1000);
		}
	break;
	case 2:
		instance_destroy(e);
		instance_destroy(e2);
		instance_destroy();
		global.paused = 0;
		close_window();
	break;
}