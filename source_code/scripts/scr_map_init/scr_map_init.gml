#macro BUILDING_N 50 //地图建筑物和地点总数
#macro NAVI_POINT_N 109 //导航点总数

function map_init(){
	var building = [[1729,2217], [1566,1964], [1575,2669], [861,2696], [880,1801], [1720,1350],
	[730, 1404], [1024, 1404], [730,1160], [1024,1160], [730, 850], [1024,850], [445, 1223], [445, 800], [730,672], [1024,672], 
	[2063, 998], [1350, 970], [2072, 1332], [2400, 1332], 
	[2406, 2524], [2298, 1800], [2424, 1800],
	[2081, 2235], [1421, 681], [1430, 1187], [1430, 1404], [1349, 2217], [1503, 2250], [889, 2226],
	[1385, 1684], [1590, 1750], [1800, 1650], [2072, 709],
	[2081, 2669], [2081, 1800], [455, 2460], [464, 2740], [2370, 826], [1981, 2958], 
	[1240, 456], [292, 2253], [2600, 1558], [1530, 3100],
	[464, 1810], [464, 2100], [889, 2949], [1347, 2940], [1665, 980], [1720, 727]
	];
var mappoint_info = [[], [555, 730, 1, 13, 2, [2, 7]], 
[708, 730, 2, 14, 2, [1,3]],
[865, 730, 3, -1, 3, [2,4,9]],
[1040, 730, 4, 15, 2, [3,5]],
[1230, 730, 5, -1, 3, [4,6,94]],
[1230, 642, 6, 24, 2, [5,93]],
[555, 894, 7, -1, 5, [1,8,18,19,20]],
[716, 894, 8, 10, 5, [7,9,18,19,20]],
[865, 894, 9, -1, 8, [3,8,10,18,19,20,21,22]],
[1040,894, 10,11, 5, [9,11,20,21,22]],
[1230,894, 11,17, 5, [10,20,21,22,94]],
[1600,803, 12,48, 2, [13,94]],
[1710,803, 13,49, 2, [12,14]],
[1910,803, 14,33, 2, [13,15]],
[1910,845, 15,-1, 3, [14,16,23]],
[2170,845, 16,38, 2, [15,17]],
[2170,950, 17,16, 2, [16,24]],
[555,1078, 18,12, 3, [7,19,26]],
[716,1078, 19, 8, 2, [18,20]],
[865,1078, 20,-1, 8, [7,8,9,10,11,19,21,27]],
[1040,1078,21, 9, 5, [9,10,11,20,22]],
[1230,1078,22,-1, 6, [9,10,11,21,28,105]],
[1910,1078,23,-1, 4, [15,24,34,105]],
[2170,1078,24,-1, 3, [17,23,25]],
[2236,1078,25,-1, 4, [24,35,28,105]],
[555, 1205,26,12, 4, [18,27,36,37]],
[865, 1205,27,-1, 7, [20,26,28,29,36,37,38]],
[1230,1205,28,-1, 6, [22,27,29,37,105,25]],
[1230,1270,29,-1, 7, [27,28,30,31,32,37,38]],
[1410,1270,30,-1, 4, [29,31,32,105]],
[1410,1230,31,25, 3, [29,30,106]],
[1410,1340,32,26, 8, [29,30,106,38,43,46,47,107]],
[1580,1270,33, 5, 1, [106]],
[1910,1290,34,18, 2, [23,50]],
[2236,1300,35,19, 2, [25,52]],
[555, 1327,36,12, 4, [26,27,37,39]],
[865, 1327,37,-1, 7, [26,27,28,29,36,38,41]],
[1230,1327,38,-1, 6, [29,37,43,32,47,107]],
[555, 1455,39,-1, 4, [36,40,44,45]],
[720, 1455,40, 6, 4, [39,41,44,45]],
[865, 1455,41,-1, 6, [37,40,42,44,45,46]],
[1090,1455,42, 7, 4, [41,43,45,46]],
[1230,1455,43,-1, 7, [38,42,45,46,32,47,107]],
[555, 1545,44,-1, 5, [39,40,41,45,55]],
[865, 1545,45,-1, 7, [39,40,41,42,43,44,46]],
[1230,1545,46,-1, 7, [41,42,43,45,47,61,32]],
[1365,1545,47,30, 5, [46,107,43,38,32]],
[1580,1545,48,31, 2, [49,107]],
[1800,1545,49,32, 2, [48,50]],
[1910,1545,50,-1, 7, [34,49,51,64,65,66,67]],
[2205,1545,51,-1, 7, [50,52,63,64,65,67,101]],
[2236,1545,52,-1, 3, [35,51,53]],
[2437,1545,53,22, 2, [52,104]],
[2580,1545,54,42, 1, [104]],
[555, 1770,55,44, 2, [44,56]],
[555, 1864,56, 4, 2, [55,57]],
[555, 1975,57,-1, 5, [56,58,69,72,79]],
[880, 1975,58,-1, 8, [57,59,60,71,72,73,78,80]],
[880, 1840,59, 4, 1, [58]],
[1230,1975,60,-1, 5, [58,62,72,79,100]],
[1230,1770,61, 4, 2, [46,100]],
[1230,2010,62,-1, 6, [60,73,74,75,76,102]],
[1910,2010,63,-1, 6, [51,65,67,83,101,102]],
[1910,1725,64,35, 6, [50,51,65,66,67,101]],
[2055,2010,65,23, 7, [50,51,63,64,66,67,101]],
[2205,2010,66,-1, 6, [50,64,65,67,68,101]],
[2205,1725,67,21, 7, [50,51,63,64,65,66,101]],
[2250,2010,68,-1, 3, [66,77,103]],
[555, 2090,69,45, 2, [57,71]],
[295, 2215,70,41, 1, [71]],
[555, 2215,71,-1, 6, [58,69,70,72,78,79]],
[880, 2215,72,29, 8, [57,58,60,71,73,78,79,80]],
[1230,2215,73,-1, 6, [58,62,72,74,79,80]],
[1345,2215,74,27, 6, [62,73,75,80,81,102]],
[1500,2215,75,28, 6, [62,74,76,80,81,102]],
[1590,2215,76, 0, 5, [62,75,80,81,102]],
[2250,2160,77,20, 2, [68,84]],
[555, 2438,78,36, 5, [58,71,72,79,85]],
[880, 2488,79, 3, 7, [57,60,71,72,73,78,80]],
[1230,2438,80,-1, 9, [58,72,73,74,75,76,79,81,88]],
[1590,2438,81,-1, 6, [74,75,76,80,82,83]],
[1590,2555,82, 2, 1, [81]],
[1910,2438,83,-1, 4, [63,81,84,109]],
[2250,2438,84,-1, 3, [77,83,95]],
[555, 2595,85, 3, 2, [78,86]],
[555, 2715,86,37, 2, [85,96]],
[965, 2838,87,46, 2, [96,97]],
[1230,2600,88, 3, 2, [80,108]],
[1350,2838,89,47, 2, [90,97]],
[1910,2838,90,39, 3, [89,91,109]],
[2076,2838,91,34, 2, [90,95]],
[1532,3040,92,43, 1, [99]],
[1230, 460,93,40, 1, [6]],
[1230, 803,94,-1, 3, [5,11,12]],
[2250,2838,95,-1, 2, [84,91]],
[555, 2838,96,-1, 2, [86,87]],
[1230,2838,97,-1, 4, [87,89,98,108]],
[1230,3040,98,-1, 2, [97,99]],
[1532,3040,99,-1, 2, [92,98]],
[1230,1900,100,1, 2, [60,61]],
[1910,1900,101,1, 6, [51,63,64,65,66,67]],
[1590,2010,102,1, 5, [62,63,74,75,76]],
[2550,2010,103,-1,2, [68,104]],
[2550,1545,104,-1,2, [53,54]],
[1550,1078,105,-1,5, [22,23,106,28,25]],
[1550,1270,106,-1,6, [30,31,32,33,105,107]],
[1550,1545,107,-1,6, [47,48,106,32,38,43]],
[1230,2630,108, 2,2, [88,97]],
[1910,2630,109, 2,2, [83,90]],

];

//每个建筑物对应的入口点号
global.entrance = [
[1,76], [3,100,101,102],[3,82,108,109],[3, 79, 85, 88], [3, 56, 59, 61], [1,33],
[1, 40], [1, 42], [1, 19], [1,21], [1, 8],
[1, 10], [3, 18, 26, 36], [1, 1], [1, 2], [1, 4],
[1, 17], [1, 11], [1, 34], [1, 35], [1, 77], 
[1, 67], [1, 53], [1, 65], [1, 6], [1, 31], 
[1, 32], [1, 74], [1, 75], [1, 72], [1, 47],
[1, 48], [1, 49], [1, 14], [1, 91], [1, 64],
[1, 78], [1, 86], [1, 16], [1, 90], [1, 93],
[1, 70], [1, 54], [1, 92], [1, 55], [1, 69],
[1, 87], [1, 89], [1, 12], [1, 13]];
	//产生建筑点
	for (var i=0;i<BUILDING_N;i++){
		global.building_point[i] = instance_create_depth(-50, -50, 25, Mappoint);
		global.building_point[i].xx = building[i][0];
		global.building_point[i].yy = building[i][1];
		global.building_point[i]._id = i;
		global.building_point[i].father = global.map;
	}
	//产生导航点
	for (var i=1;i<=NAVI_POINT_N;i++){
		global.navipoint[i] = instance_create_depth(-10, -10, 26, Navipoint);
		global.navipoint[i].xx = mappoint_info[i][0];
		global.navipoint[i].yy = mappoint_info[i][1];
		global.navipoint[i]._id = mappoint_info[i][2];
		global.navipoint[i].building = mappoint_info[i][3];
		global.navipoint[i].num = mappoint_info[i][4];
		global.navipoint[i].e = mappoint_info[i][5];
	}
	for (var i=1;i<=NAVI_POINT_N;i++){
		for (var j=0;j<global.navipoint[i].num;j++){
			global.navipoint[i].d[j] = sqrt(sqr(global.navipoint[i].xx-global.navipoint[global.navipoint[i].e[j]].xx)+sqr(global.navipoint[i].yy-global.navipoint[global.navipoint[i].e[j]].yy));
		}
	}
	instance_create_depth(-20,-20,22,Startpoint);
	instance_create_depth(-20,-20,23,Endpoint);

	memset2(global.mappoint_dis, BUILDING_N, BUILDING_N, INT_MAX);

}