#macro WINDOW_WIDTH 1680 //窗口宽度
#macro WINDOW_HEIGHT 1050 //窗口高度

//日程类型枚举
enum schedule_type
{
    test,
	course,
	collective_activity,
	individual_activity,
	tempstuff
}
//时间对应的字符串
global.weeks=["无考试","第一周","第二周","第三周","第四周", "第五周", "第六周","第七周","第八周","第九周", "第十周","第十一周","第十二周","第十三周","第十四周", "第十五周","第十六周"];
global.weeks2=["第一周","第二周","第三周","第四周", "第五周", "第六周","第七周","第八周","第九周", "第十周","第十一周","第十二周","第十三周","第十四周", "第十五周","第十六周"];
global.weekdays=["星期一","星期二","星期三","星期四","星期五","星期六","星期日"];
global.days=["星期一","星期二", "星期三","星期四","星期五", "星期六", "星期日", "每天", "工作日", "双休日"];
global.hours=["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"];
//闹钟对应的字符串
global.clockweeks=["每周","第一周","第二周","第三周","第四周", "第五周", "第六周","第七周","第八周","第九周", "第十周","第十一周","第十二周","第十三周","第十四周", "第十五周","第十六周"];
global.clockdays=["自定义","星期一","星期二", "星期三","星期四","星期五", "星期六", "星期日", "每天", "工作日", "双休日"];
//预设的活动与临时事务类型
global.enum_individual_activity=["自习","锻炼","外出","散步","阅读","复习","跑步"];
global.enum_collective_activity=["班会","运动会","小组作业","创新创业","聚餐","志愿活动","晚会"];
global.enum_tempstuff=["吃饭","购物","洗澡","取外卖","取快递","送取东西","理发"];
//不同类型的日程对应的颜色
global.colors = [0xEE3A8C, #EE6A50, #EE9A00, 0x00FF66, 0xffff33];

#macro SITE_N 51 //地图建筑物和地点总数

//地点名称
global.sites = ["主楼","教一楼","教二楼","教三楼","教四楼","图书馆",
"学一公寓","学二公寓","学三公寓","学四公寓","学五公寓","学八公寓","学十三公寓","青年公寓","留学生公寓",
"综合食堂","学生食堂","麦当劳",
"篮球场","网球排球场","体育场","体育馆","游泳馆",
"科学会堂","学生活动中心","小松林","时光广场","国旗","中央喷泉","校训石",
"财务处","行政办公楼","物业中心",
"科研楼","创新楼","停车场","停车坪","校车车库","北家属区","南家属区",
"北门","西门","东门","南门",
"邮局","快递站","校医院","中门邮局","物美超市","浴室",
"线上"];