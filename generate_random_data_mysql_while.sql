-- <generate random data>
-- include chinese_name, sex, birthday, age, phone_number, chinese_address, slarary, email, chinese_job, status, entry_time, modify_time
-- this mysql procedure just randomize simple but non-standard information
-- you can try modify this procedure with function, if you thought it was dirty
-- efficiency for >> while >= loop
-- author: emirio
-- version: v1.0
-- date: 2020/6/12
-- tool: Navicat 12

-- USE #db_name < should use a database to manipulate first >

-- create procedure using by delimiter command
DELIMITER && # set new delimiter
DROP PROCEDURE IF EXISTS generate_random_data; # drop insert_multi procedure if it exists
CREATE PROCEDURE generate_random_data(IN data_num INT) # generate data_num rows with random data
BEGIN
	DECLARE num INT DEFAULT 1; 
	DECLARE e_name CHAR(30); 
	DECLARE e_sex INT; 
	DECLARE e_birthday DATE; 
	
	-- e_age = current_date - e_birthday
	DECLARE e_age INT;
	
	-- e_phone = e_head + e_content
	DECLARE e_head CHAR(3);
	DECLARE e_content INT;
	DECLARE e_phone CHAR(11);

	-- e_address = e_province + e_city + e_district + e_road + e_building
	DECLARE e_province VARCHAR(12);
	DECLARE e_city VARCHAR(12);
	DECLARE e_district VARCHAR(12);
	DECLARE e_road VARCHAR(12);
	DECLARE e_building VARCHAR(16);
	DECLARE e_address VARCHAR(100);
	
	DECLARE e_salary DECIMAL;
	
	-- email = email_prefix + email_suffix
	DECLARE e_email_prefix VARCHAR(25);
	DECLARE e_email_suffix VARCHAR(10);
	DECLARE e_email VARCHAR(35);
	
	DECLARE e_job char(10);
	DECLARE e_status TINYINT;
	DECLARE e_dept_id BIGINT;
	DECLARE e_entry_time DATE;
	DECLARE e_modify_time DATE;
	
	-- initialize insert statement with @sql_statement + @sql_values
	SET @sql_statement = 'INSERT INTO sys_employee (name, sex, birthday, age, phone, address, salary, email, job, status, dept_id, entry_time, modify_time) values';
	SET @sql_values = '';
	
	-- < LENGTH(@S_NAME) / 3 > (chinese_character cost 3bytes in database)
	-- set surname
	SET @S_NAME = '王李张刘陈杨黄赵吴周徐孙马朱胡郭何高林罗郑梁谢宋唐位许韩冯邓曹彭曾萧田董潘袁于蒋蔡余杜叶程苏魏吕丁任沈姚卢姜崔钟谭陆汪范金石廖贾夏韦傅方白邹孟熊秦邱江尹薛阎段雷侯龙史陶黎贺顾毛郝龚邵万钱严覃武戴莫孔向汤';
	-- set given name
	SET @G_NAME = '丹举义之乐书乾云亦从代以伟佑俊修健傲儿元光兰冬冰冷凌凝凡凯初力勤千卉半华南博又友同向君听和哲嘉国坚城夏夜天奇奥如妙子存季孤宇安宛宸寒寻尔尧山岚峻巧平幼康建开弘强彤彦彬彭心忆志念怀怜恨惜慕成擎敏文新旋旭昊明易昕映春昱晋晓晗晟景晴智曼朋朗杰松枫柏柔柳格桃梦楷槐正水沛波泽洁洋济浦浩海涛润涵渊源溥濮瀚灵灿炎烟烨然煊煜熙熠玉珊珍理琪琴瑜瑞瑶瑾璞痴皓盼真睿碧磊祥祺秉程立竹笑紫绍经绿群翠翰致航良芙芷苍苑若茂荣莲菡菱萱蓉蓝蕊蕾薇蝶觅访诚语谷豪赋超越轩辉达远邃醉金鑫锦问雁雅雨雪霖霜露青靖静风飞香驰骞高鸿鹏鹤黎';
	
	-- set province, city, district, road, building
    -- you can add more city, district, road, building or other information
	SET @tmp_province = '河北省,山西省,辽宁省,吉林省,黑龙江,江苏省,浙江省,安徽省,福建省,江西省,山东省,河南省,湖北省,湖南省,广东省,海南省,四川省,贵州省,云南省,陕西省,甘肃省,青海省,台湾省';
	SET @tmp_city = '安康市,安庆市,安顺市,安阳市,鞍山市,巴中市,白城市,白山市,白银市,百色市,蚌埠市,包头市,宝鸡市,保定市,保山市,北海市,本溪市,滨州市,沧州市,昌都市,长春市,长沙市,长治市,常德市,常州市,巢湖市,朝阳市,潮州市,郴州市,成都市,承德市,池州市,赤峰市,崇左市,滁州市,达州市,大连市,大庆市,大同市,丹东市,德阳市,德州市,定西市,东莞市,东营市,鄂州市,佛山市,福州市,抚顺市,抚州市,阜新市,阜阳市,甘南州,赣州市,固原市,广安市,广元市,广州市,贵港市,贵阳市,桂林市,哈尔滨,海口市,邯郸市,汉中市,杭州市,毫州市,合肥市,河池市,河源市,菏泽市,贺州市,鹤壁市,鹤岗市,黑河市,衡水市,衡阳市,呼和市,呼伦市,湖州市,葫芦市,怀化市,淮安市,淮北市,淮南市,黄冈市,黄山市,黄石市,惠州市,鸡西市,吉安市,吉林市,济南市,济宁市,佳木市,嘉兴市,嘉峪市,江门市,焦作市,揭阳市,金昌市,金华市,锦州市,晋城市,晋中市,荆门市,荆州市,景德镇,九江市,酒泉市,开封市,克拉市,昆明市,拉萨市,来宾市,莱芜市,兰州市,廊坊市,乐山市,丽江市,丽水市,连云港,辽阳市,辽源市,聊城市,临沧市,临汾市,临沂市,柳州市,六安市,六盘水,龙岩市,陇南市,娄底市,泸州市,吕梁市,洛阳市,漯河市,马鞍山,茂名市,眉山市,梅州市,绵阳市,牡丹江,内江市,南昌市,南充市,南京市,南宁市,南平市,南通市,南阳市,宁波市,宁德市,攀枝花,盘锦市,平顶山,平凉市,萍乡市,莆田市,濮阳市,普洱市,钦州市,秦皇岛,青岛市,清远市,庆阳市,曲靖市,衢州市,泉州市,日照市,三门峡,三明市,三亚市,汕头市,汕尾市,商洛市,商丘市,上饶市,韶关市,邵阳市,绍兴市,深圳市,沈阳市,十堰市,石家庄,石嘴山,双鸭山,朔州市,四平市,松原市,苏州市,宿迁市,宿州市,绥化市,随州市,遂宁市,台州市,太原市,泰安市,泰州市,唐山市,天水市,铁岭市,通化市,通辽市,铜川市,铜陵市,铜仁市,吐鲁番,威海市,潍坊市,渭南市,温州市,乌海市,乌兰市,乌鲁市,无锡市,吴忠市,芜湖市,梧州市,武汉市,武威市,西安市,西宁市,锡林郭,厦门市,咸宁市,咸阳市,湘潭市,襄樊市,孝感市,忻州市,新乡市,新余市,信阳市,兴安盟,邢台市,徐州市,许昌市,宣城市,雅安市,烟台市,延安市,盐城市,扬州市,阳江市,阳泉市,伊春市,伊犁哈,宜宾市,宜昌市,宜春市,益阳市,银川市,鹰潭市,营口市,永州市,榆林市,玉林市,玉溪市,岳阳市,云浮市,运城市';
	SET @tmp_district = '伊春区,带岭区,南岔区,金山区,西林区,美溪区,乌马区,翠峦区,友好区,新青区,甘岭区,五营区,红星区,汤旺区,伊岭区,榆次区';
	SET @tmp_road = '爱国路,安边路,安波路,安德路,安汾路,安福路,安国路,安化路,安澜路,安龙路,安仁路,安顺路,安亭路,安图路,安业路,安义路,安远路,鞍山路,鞍山路,澳门路,八一路,巴林路,白城路,白城路,白渡路,白渡桥,白兰路,白水路,白玉路,百安路,方泰镇,百官街,百花街,百色路,板泉路,半淞路,包头路,包头路,宝安路,宝安路,宝昌路,宝联路,宝林路,宝祁路,宝山路,宝通路,宝杨路,宝源路,保德路,保定路,保屯路,保屯路,北艾路';
	SET @tmp_building = '金色家园,耀江花园,阳光翠苑,东新大厦,溢盈别墅,真新六街,和亭佳苑,协通公寓,博泰新苑,菊园五街,住友名园,复华花园,爱里花园';
	
	-- set mail suffix type
	SET @mail_suffix = '@gmail.com,@yahoo.com,@12345.com,@tecen.com,@googo.com,@tenqq.com';
	
	-- set job type
	SET @tmp_job = '开发员,销售员,美工员,策划员,清洁员,管理员,工程师,研发师,演讲师,操作员,配送员,防卫员,医护员,技术员,信息员,实施员,维护员';
	
	-- loop data_num times
    -- the efficiency order: for >> while >= loop
	WHILE num <= data_num DO
		-- set employee name
		SET e_name = CONCAT(SUBSTR(@S_NAME,FLOOR(RAND()*LENGTH(@S_NAME)/3+1),1), SUBSTR(@G_NAME,FLOOR(RAND()*LENGTH(@G_NAME)/3+1),1), SUBSTR(@G_NAME,FLOOR(RAND()*LENGTH(@G_NAME)/3+1),1));
		
		-- set employee gender
		SET e_sex = FLOOR(1 + RAND() * 3);
		
		-- set employee birthday
		SET e_birthday = DATE(FROM_UNIXTIME(UNIX_TIMESTAMP('1980-01-01') + FLOOR(RAND() * (UNIX_TIMESTAMP('2002-01-01') - UNIX_TIMESTAMP('1980-01-01') + 1 ))));
		
		-- set employee age with birthday
		SET e_age = TIMESTAMPDIFF(YEAR, e_birthday, CURDATE());
		
		-- set phone number
		SET e_head = SUBSTRING('171,136,176,183,188,133,177,155,139,153', 1+(FLOOR( (RAND() * 10))*4), 3);
		SET e_content = FLOOR(RAND() * 100000000);
		SET e_phone = CONCAT(e_head,e_content);	
		
		-- set address
		SET e_province = SUBSTRING(@tmp_province, 1 + (FLOOR(RAND() * 23) * 4), 3);
		SET e_city = SUBSTRING(@tmp_city, 1 + (FLOOR(RAND() * 264) * 4), 3);
		SET e_district = SUBSTRING(@tmp_district, 1 + (FLOOR(RAND() * 16) * 4), 3);
		SET e_road = SUBSTRING(@tmp_road, 1 + (FLOOR(RAND() * 53) * 4), 3);
		SET e_building = SUBSTRING(@tmp_building, 1 + (FLOOR(RAND() * 13) * 5), 4);
		SET e_address = CONCAT(e_province, e_city, e_district, e_road, e_building);
		
		-- set salary
		SET e_salary = FLOOR(20 + RAND() * 300) * 100;
		
		-- set email
		SET e_email_prefix = SUBSTRING(MD5(RAND()), 1, 20);
		SET e_email_suffix = SUBSTRING(@mail_suffix, 1 + (FLOOR(RAND() * 6) * 11), 10);
		SET e_email = CONCAT(e_email_prefix, e_email_suffix);
		
		-- set job
		SET e_job = SUBSTRING(@tmp_job, 1 + (FLOOR(RAND() * 17) * 4), 3);
		
		-- set status
		SET e_status = FLOOR(RAND() * 2);
		
		-- set dept_id
		SET e_dept_id = FLOOR(RAND() * 50);
		
		-- set entry time
		SET e_entry_time = DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(CURDATE()) - FLOOR(RAND() * (UNIX_TIMESTAMP('1985-01-01') - UNIX_TIMESTAMP('1980-01-01') + 1 ))));
		
		-- set modify time
		SET e_modify_time = e_entry_time;
		
		-- set @sql_values, use "\"" & "\"" format string and date type
		-- set insert into statement
		SET @sql_values = CONCAT(@sql_values, "(", "\"",e_name, "\"", ",", e_sex, ",","\"", e_birthday, "\"",",", e_age, ",\"", e_phone,"\"",",","\"", e_address,"\"", ",", e_salary, ",", "\"", e_email,"\"", ",", "\"", e_job, "\"", ",", e_status, ",", e_dept_id, ",", "\"", e_entry_time, "\"", ",", "\"", e_modify_time, "\"",")");
		
		-- commit transcation per 1000 rows of data
        -- current best efficency of batch transaction is 1000 in 1,000,000 rows data
		IF num % 1000 = 0 THEN
			SET @sql_statement = CONCAT(@sql_statement, @sql_values, ";");
			
			-- commit transcation
			PREPARE statement FROM @sql_statement;
			EXECUTE statement;
			DEALLOCATE PREPARE statement;
			COMMIT;
			
			-- set initial statement
			SET @sql_statement = 'INSERT INTO sys_employee (name, sex, birthday, age, phone, address, salary, email, job, status, dept_id, entry_time, modify_time) values';
			SET @sql_values = '';
		ELSE
			SET @sql_values = CONCAT(@sql_values, ',');
		END IF;
		
		SET num = num + 1;
	END WHILE;

END
&&

DELIMITER ;
CALL generate_random_data(10000); # specify a number to generate rows
DROP PROCEDURE IF EXISTS generate_random_data;
