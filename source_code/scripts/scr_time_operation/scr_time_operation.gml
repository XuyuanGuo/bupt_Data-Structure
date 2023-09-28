function init_time(_a, _b, _c) constructor{
	week = _a; day = _b; time = _c; len = _c+1; edweek = _a;
	tp = 5;
}

//计算在主页面上显示的当前时间
function get_time(){
	return string(global.hour)+":"+(floor(global.time)<10?"0":"")+string(floor(global.time));
}

function time_to_filename(_a){
	return string(_a.week) +"_" + string(_a.day)+ "_" +string(_a.time);
}

function is_time_conflict(_a, _b){
	var w1 = _a.week, d1=_a.day, t1=_a.time, e1=_a.edweek, l1=_a.time+1;
	var w2 = _b.week, d2=_b.day, t2=_b.time, e2=_b.edweek, l2=_b.time+1;
	if (_a.tp==4 || _a.tp==0) e1=w1;
	if (_b.tp==4 || _b.tp==0) e2=w2;
	if (_a.tp<2) l1=_a.len;
	if (_b.tp<2) l2=_b.len;
	if (_a.tp==1 && _b.tp==1 && _a.test_week && is_time_conflict(new init_test(_a),new init_test(_b))) return 1;
	else if (_a.tp==1 && _b.tp>1 && is_time_conflict(new init_test(_a),_b)) return 1;
	else if (_b.tp==1 && _a.tp>1 && is_time_conflict(new init_test(_b),_a)) return 1;
	if ((e1>=w2 && w1<=e2) || (e2>=w1 && w2<=e1)){
		if (d1==d2 || d1==7 || d2==7 || (d1==8 && d2<5) || (d1==9 && (d2==5 || d2==6)) || (d2==8 && d1<5) || (d2==9 && (d1==5 || d1==6))){
			if ((l1>t2 && t1<l2) || (l2>t1 && t2<l1)){
				return 1;
			}
		}
	}
	return 0;
}

function time_to_text(_a){
	var str="";
	if (!_a.edweek) str = global.weeks[_a.week];
	else if(_a.edweek==_a.week) str = global.weeks[_a.week];
	else str = global.weeks[_a.week] + "-" + global.weeks[_a.edweek];
	str = str + " " + global.days[_a.day] + " " + global.hours[_a.time];
	if (_a.tp==1) str = str + "-" + global.hours[_a.len];
	return str;
}

function place_to_text(_a){
	var str;
	if ((_a.tp!=1 || _a.building<5) && _a.building!=BUILDING_N){
		str = global.sites[_a.building];
		if (_a.building<5) str = str + string(_a.classroom);
		if (_a.tp>=1 && _a.tp<4 && _a.online_platform!=""){
			str = str + "\n线上链接：" + _a.online_platform + _a.online_link;
		}
	}else{
		str = _a.online_platform + _a.online_link;
	}
	return str;
}

function place_to_text2(_a){
	var str;
	if ((_a.tp!=1 || _a.building<5) && _a.building!=BUILDING_N){
		str = global.sites[_a.building];
		if (_a.building<5) str = str + string(_a.classroom);
	}else{
		str = _a.online_platform + _a.online_link;
	}
	return str;
}

function time_to_int(_a){
	return _a.week*24*7 + _a.day*24 + _a.time;
}
function is_time_valid(a)
{
    //周数不在范围内
    if(a.edweek<global.week || a.week>global.week)
        return false;
    //最后一周
    if(a.edweek==global.week)
    {
        //已超过天数
        if(a.day<global.day)
            return false;
        //已超过时间
        if(a.len<=global.time)
        {
            //最后一天
            if(a.day==global.day || (a.day==7 && global.day==6) ||
            (a.day==8 && global.day==4) || (a.day==9 && global.day==6) )
                return false;
        }
    }
    return true;

}
function time_to_int2(a){
	if (a.tp==4) a.edweek=a.week;
    if(!is_time_valid(a))
        return a.week*24*7+a.day*24+a.time;

    var tmp=new init_time(global.week, global.day, global.hour);//下一次发生的时间
    if(a.day==7)
    {
        if(a.len<=global.time)
        {
           tmp.day++;
           //如果下一天超过本周
           if(tmp.day==7)
           {
               tmp.week++;
               tmp.day=0;
           }
        }
		tmp.time=a.time;
    }else if(a.day==8)
    {
        if(global.day>=0 && global.day<=4)
        {
            if(a.len>global.time)
                tmp.day=global.day;
            else
                tmp.day=global.day+1;
            if(tmp.day==5)
            {
                tmp.week++;
                tmp.day=0;
            }
        }else{
            tmp.week++;
            tmp.day=0;
        }
		tmp.time=a.time;
    }else if(a.day==9)
    {
        if(global.day==5 || global.day==6)
        {
            if(a.len>global.time)
                tmp.day=global.day;
            else
                tmp.day=global.day+1;
            if(tmp.day==7)
            {
                tmp.week++;
                tmp.day=5;
            }
        }else{
            tmp.week++;
            tmp.day=5;
        }
		tmp.time=a.time;
    }else if (a.day < global.day){
        tmp.week++;
		tmp.day=a.day;
		tmp.time = global.hour;
	}else if (a.day==global.day && a.len <= global.hour) {
        tmp.week++;
		tmp.day=a.day;
		tmp.time = a.time;
    }else{
		tmp.day=a.day;
		tmp.time = max(a.time,tmp.time);
	}

    return tmp.week*24*7 + tmp.day*24 + tmp.time;
}