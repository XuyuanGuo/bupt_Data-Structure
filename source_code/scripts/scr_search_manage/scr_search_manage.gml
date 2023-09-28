
function id_to_schedule_key(_a, j){
	switch (_a.tp){
		case 0: return j;
		break;
		case 1:	return j + course_N;
		break;
		case 2: return j + 2*course_N;
		break;
		case 3: return j + 2*course_N; 
		break;
		case 4: return j + 2*course_N + activity_N;
		break;
		default: return -4;
	}
}

function schedule_key_to_id(_key){
	if (_key>=2*course_N + activity_N) return _key-2*course_N-activity_N;
	if (_key>2*course_N) return _key - 2*course_N;
	if (_key>course_N) return _key - course_N;
	return _key;
}

function key_to_schedule(_key){
	if (_key>=2*course_N + activity_N) return global.tempstuffList[schedule_key_to_id(_key)];
	if (_key>2*course_N) return read_activity_info(schedule_key_to_id(_key));
	if (_key>course_N) return read_course_info(schedule_key_to_id(_key));
	if (_key>=0) return new init_test(read_course_info(schedule_key_to_id(_key)));
	return noone;
}

function create_schedule_hash(_a, _id){
    var _s = _a._name;
	var l = string_length(_s);
    for(var i=1;i<=l;i++){
		for (var j=l-i+1;j>0;j--){
			var linklist = global.search_hash.get(string_copy(_s, i, j));
			if (linklist==noone) linklist = global.search_hash.set(string_copy(_s, i, j), new init_linklistHead());
			linklist.insert_norep(id_to_schedule_key(_a, _id));
		}
    }
	with (Searchbar) refresh();
}

function delete_schedule_hash(_a, _id){
    var _s = _a._name;
	var l = string_length(_s);
    for(var i=1;i<=l;i++){
		for (var j=l-i+1;j>0;j--){
			var linklist = global.search_hash.get(string_copy(_s, i, j));
			if (linklist==noone) continue;
			linklist.remove(id_to_schedule_key(_a, _id));
		}
    }
	with (Searchbar) refresh();
}

function update_schedule_hash(pa, pid, na, nid){
	delete_schedule_hash(pa, pid);
	create_schedule_hash(na, nid);
}
