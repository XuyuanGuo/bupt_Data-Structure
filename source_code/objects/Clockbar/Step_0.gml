/// @description Insert description here
// You can write your code in this editor
switch (state){
	//刷新
	case 0:
		if (e[0].chose!=-1){
			chose = e[0].chose;
			chooselist[0].chose = global.clockList[3+3*e[0].chose];
			chooselist[1].chose = global.clockList[2+3*e[0].chose];
			chooselist[2].chose = global.clockList[1+3*e[0].chose]-6;
			if (chooselist[1].chose >= 128){
				var p = chooselist[1].chose;
				chooselist[1].chose = 0;
				for (var i = 0; i<7; i++){
					if ((p>>i&1)==1) e[5].textlabel[i].outline = 1;
					else e[5].textlabel[i].outline = 0;
				}
			}else{
				for (var i = 0; i<7; i++) e[5].textlabel[i].outline = 0;
			}
			state = 1;
		}
	break;
	//显示
	case 1:
		if (e[0].chose != chose){
			chose = e[0].chose;
			state = 0;
		}
	break;
	case 2:
		e[0].state = 2;
		e[5].state = 2;
		for (var i = 0; i<1; i++) instance_destroy(textlabel[i]);
		for (var i = 0; i<3; i++) instance_destroy(chooselist[i]);
		for (var i = 1; i<5; i++) instance_destroy(e[i]);
		close_window();
		instance_destroy();
	break;
}