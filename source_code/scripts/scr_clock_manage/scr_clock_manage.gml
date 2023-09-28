function save_clock_info(){
	file_write(12*1024, global.clockList, buffer_s32, global.clockList[0]*3, 4, working_directory + "Users/" + global.student + "/clock.sav");
}

function clock_insert(_week, _day, _time){
	var l = global.clockList[0]*3;
	for (var i = 1; i<l+3; i+=3){
		if (i>=l || global.clockList[i]>=_time){
			for (var j=l; j>i; j-=3){
				global.clockList[j+3]=global.clockList[j];
				global.clockList[j+2]=global.clockList[j-1];
				global.clockList[j+1]=global.clockList[j-2];
			}
			global.clockList[i]=_time;
			global.clockList[i+1]=_day;
			global.clockList[i+2]=_week;
			break;
		}
	}
	global.clockList[0]++;
}

function clock_delete(_id){
	var l = global.clockList[0]*3;
	for (var i = _id*3+1; i<=l; i+=3){
		global.clockList[i]=global.clockList[i+3];
		global.clockList[i+1]=global.clockList[i+4];
		global.clockList[i+2]=global.clockList[i+5];
	}
	global.clockList[0]--;
}

function update_clocktable(_week, _day, _time){
	var _p = _day;
	if (_day<=7){
		_p = 1<<(_day-1);
	}else if (_day==8){
		_p = 127;
	}else if (_day==9){
		_p = 127-96;
	}else if (_day==10){
		_p = 96;
	}
	if (_week){
		for (var i=0; i<7; i++) if ((_p>>i)&1==1) global.clockTable[_week-1][i][_time-6] = 1;
	}else{
		for (var j=0; j<16; j++){
			for (var i=0; i<7; i++) if ((_p>>i)&1==1) global.clockTable[j][i][_time-6] = 1;
		}
	}
}

function create_clocktable(){
	for (var i=15; i>=0; i--)
		for (var j=6; j>=0; j--)
			for (var k=16; k>=0; k--)
				global.clockTable[i][j][k]=0;
	for (var i = global.clockList[0]*3; i>0; i-=3){
		update_clocktable(global.clockList[i], global.clockList[i-1], global.clockList[i-2]);
	}
}