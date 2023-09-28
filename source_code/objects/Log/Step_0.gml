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
		e = instance_create_depth(840-700, 525-400, -7, Logbar);
		e.father = self;
		e.create();
		state = 4;
	break;
	case 4:
	break;
}