module(..., package.seeall)
local task_id=1000;
local task_data={
	ttype="主",		focus=true,		autogo=true,
	[1	]={
		tid=1,		nid=2,		need_level=1,		name="世界那么大",	accepter="老村长",	doner="孤独芳",
		award={
			{name="起源·神兵",	num=1,itemId = 20001,flag=10,},	
			{name="起源·战甲",	num=1,gender='male',itemId = 30001,flag=10,},
			{name="等级丹(100级)", itemId = 10001,	num=5},
		},
		accept_talk = function (npc,player,td) return "咱村的年轻人大多志在四方,毛儿都没长齐就想着往外跑.罢了,早点见见世面也是好的.先去拜访下老铁吧,兴许能讨要件衬手的兵器或铠甲.";end;
		done_talk = function (npc,player,td) return "停!什么都不用说,东西已经为你准备好了!快去杀几只鸡试试!完事后记得去你金莲阿姨那看看哈.";end;
	},
	[2	]={
		tid=2,		nid=3,		need_level=1,		name="练练手",	accepter="孤独芳",	doner="端木妍",
		need_type="mon",	need_target="食腐虫",		mon_map="v0000",	need_num=1,
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=2},
		},
		drop_hook = {state=const.TSACED,mon="食腐虫",items={{name="起源·手",num=1},{name="起源·盔",num=1}}},
		accept_talk = function (npc,player,td) return "哟哟哟!还记得来看你人老珠老的金莲大妈啊!来都来了,就坐下来吃只鸡吧!(少年无语,数秒后...)好了,阿姨不逗你玩儿了!剑无痕大叔就在村外不远处,他年轻时常在外游历,多向他讨教讨教总是没错滴!";end;
		done_talk = function (npc,player,td) return "哟哟哟!还记得来看你人老珠老的金莲大妈啊!来都来了,就坐下来吃只鸡吧!(少年无语,数秒后...)好了,阿姨不逗你玩儿了!剑无痕大叔就在村外不远处,他年轻时常在外游历,多向他讨教讨教总是没错滴!";end;
	},
	[3	]={
		tid=3,		nid=4,		need_level=1,		name="蠢蠢欲动",	accepter="端木妍",	doner="柳生剑影",
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="回城石", itemId = 10001,	num=1,bind=1},
			{name="等级丹(100级)", itemId = 10001,	num=2},
		},
		accept_talk = function (npc,player,td) return ""..player:get_name().."准备出去历练了吧,不愧是我们村新生代的勇者!不过今时不同往日,苦境大陆潜伏多年的魔物们似乎正在蠢蠢欲动,建议你一定要多做些准备!";end;
		done_talk = function (npc,player,td) return ""..player:get_name().."准备出去历练了吧,不愧是我们村新生代的勇者!不过今时不同往日,苦境大陆潜伏多年的魔物们似乎正在蠢蠢欲动,建议你一定要多做些准备!";end;
	},
	
	[4	]={
		tid=4,		nid=5,		need_level=1,		name="冰山美人",	accepter="柳生剑影",	doner="童战",
		need_type="mon",	need_target="三头蛇",		mon_map="v0000",	need_num=2,
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=2},
		},
		drop_hook = {state=const.TSACED,mon="三头蛇",items={{name="起源·链",num=1},{name="起源·带",num=1}}},
		accept_talk = function (npc,player,td) return "保重";end;
		done_talk = function (npc,player,td) return "保重";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★少年心想:冰山美人说的就是她这样的人吧!★"); end;
	},
	[5	]={
		tid=5,		nid=6,		need_level=1,		name="你需要热热身",	accepter="童战",	doner="诸葛羽",
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=2},
		},
		
		accept_talk = function (npc,player,td) return "刚从冰凌妹纸那里来的吧,她那人就那样,人美若天仙性格却冷得像千年寒冰一样,大妈看呐,肯定是个有故事的人!";end;
		done_talk = function (npc,player,td) return "刚从冰凌妹纸那里来的吧,她那人就那样,人美若天仙性格却冷得像千年寒冰一样,大妈看呐,肯定是个有故事的人!";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★少年心想:冰山美人说的就是她这样的人吧!★"); end;
	},
	[6	]={
		tid=6,		nid=7,		need_level=1,		name="物竞天择",	accepter="诸葛羽",	doner="白忘机",
		need_type="mon",	need_target="火烈鸟",	mon_map="v0000",		need_num=2,
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=2},
		},
		drop_hook = {state=const.TSACED,mon="火烈鸟",items={{name="起源·戒",num=1},{name="起源·靴",num=1}}},
		accept_talk = function (npc,player,td) return "想必你剑大叔已经和你说过一些魔物有关的事情了吧!魔物不知何因再次东山再起,你看,这附近的稻草人都被赋于了意识,会攻击行人了,好在它们等级偏低,对练家子来说几乎构不成威胁,你可以用它们来练练手!";end;
		done_talk = function (npc,player,td) return "想必你剑大叔已经和你说过一些魔物有关的事情了吧!魔物不知何因再次东山再起,你看,这附近的稻草人都被赋于了意识,会攻击行人了,好在它们等级偏低,对练家子来说几乎构不成威胁,你可以用它们来练练手!";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★告别葛大妈继续前行.★"); end;
	},
	[7	]={
		tid=7,		nid=8,		need_level=1,		name="繁华大都",	accepter="白忘机",	doner="逸无踪",
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=2},
		},
		accept_talk = function (npc,player,td) return "最近魔物肆虐,比奇全城戒备,少侠诺有志愿,可以联系城中的接引人,他会指引你加入到抗魔大军的行列中除魔卫道.";end;
		done_talk = function (npc,player,td) return "最近魔物肆虐,比奇全城戒备,少侠诺有志愿,可以联系城中的接引人,他会指引你加入到抗魔大军的行列中除魔卫道.";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★果然是城里啊!真热闹!噫,前面的衣服看起来不错.★"); end;
	},
	[8	]={
		tid=8,		nid=9,		need_level=1,		name="豪城导游",	accepter="逸无踪",	doner="荆无病",
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=2},
		},
		accept_talk = function (npc,player,td) return "小伙继续往前走,右手边就是服装店,再右边是武器店,先搞身气派的行头吧!不用担心价格,魔族大战在即,城市各行各业对勇者都实行了五折优惠!";end;
		done_talk = function (npc,player,td) return "小伙继续往前走,右手边就是服装店,再右边是武器店,先搞身气派的行头吧!不用担心价格,魔族大战在即,城市各行各业对勇者都实行了五折优惠!";end;
	},
	[9	]={
		tid=9,		nid=10,		need_level=1,		name="人靠衣装",	accepter="荆无病",	doner="逸无踪",
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=2},
		},
		accept_talk = function (npc,player,td) return "(一番挑选过后)少侠果真气度非凡,欢迎下次再临.";end;
		done_talk = function (npc,player,td) return "(一番挑选过后)少侠果真气度非凡,欢迎下次再临.";end;
	},
	[10	]={
		tid=10,		nid=11,		need_level=1,		name="货源不足",	accepter="逸无踪",	doner="月灵犀",
		need_type="mon",	need_target="狗头勇士",		mon_map="v0098",	need_num=2,
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=5},
			{name="试炼·神兵",	num=1,itemId = 20001,flag=10,},	
		},
		drop_hook = {state=const.TSACED,mon="狗头勇士",items={{name="试炼·盔",num=1}}},
		accept_talk = function (npc,player,td) return "这位小侠,在下实在不好意思,由于魔物复苏的关系,比奇城突然比以往热闹了百倍,所以高级武器暂时货源不足,补偿阁下一把青铜剑廖表歉意,还望笑纳.";end;
		done_talk = function (npc,player,td) return "这位小侠,在下实在不好意思,由于魔物复苏的关系,比奇城突然比以往热闹了百倍,所以高级武器暂时货源不足,补偿阁下一把青铜剑廖表歉意,还望笑纳.";end;
	},
	[11	]={
		tid=11,		nid=12,		need_level=1,		name="战复",	accepter="月灵犀",	doner="萧鼎",
		award={
			{name="元宝",	itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=5},
		},
		accept_talk = function (npc,player,td) return "多备些药品防身吧,城外的怪物可是很凶猛的!";end;
		done_talk = function (npc,player,td) return "多备些药品防身吧,城外的怪物可是很凶猛的!";end;
	},
	[12	]={
		tid=12,		nid=13,		need_level=1,		name="二至八折等于八折",	accepter="萧鼎",	doner="战狂歌",
		need_type="mon",	need_target="铁血战士",		mon_map="v0099",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		drop_hook = {state=const.TSACED,mon="铁血战士",items={{name="试炼·甲",num=1},{name="试炼·盔",num=1}}},
		accept_talk = function (npc,player,td) return "小侠你来得正好,小店杂货最近正在进行打折活动,全场商品一律二至八折起!额,这个八折...那个也是八折...那个还是八折!(那哪些是二折呢?)二折的今天都卖完了!";end;
		done_talk = function (npc,player,td) return "小侠你来得正好,小店杂货最近正在进行打折活动,全场商品一律二至八折起!额,这个八折...那个也是八折...那个还是八折!(那哪些是二折呢?)二折的今天都卖完了!";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★准备得差不多了,该不多该出城看看了.★"); end;
	},
	[13	]={
		tid=13,		nid=14,		need_level=1,		name="万事俱备",	accepter="战狂歌",	doner="玄慧",
		need_type="mon",	need_target="变异蝰蛇",		mon_map="v0099",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "勇士你准备出城了么?前去不远便是骷髅洞,环境异常复杂,进后后一定要先去孤中剑大侠那边听一下情报再行动!";end;
		done_talk = function (npc,player,td) return "勇士你准备出城了么?前去不远便是骷髅洞,环境异常复杂,进后后一定要先去孤中剑大侠那边听一下情报再行动!";end;
	},
	[14	]={
		tid=14,		nid=15,		need_level=1,		name="腐烂的味道",	accepter="玄慧",	doner="玄空",
		need_type="mon",	need_target="青铜战将",		mon_map="v0099",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		drop_hook = {state=const.TSACED,mon="青铜战将",items={{name="试炼·戒",num=1},{name="试炼·甲",num=1}}},
		accept_talk = function (npc,player,td) return "此洞原名罪恶坑,在远久的年代是一座用来处理战后士兵的乱葬洞.在近日随着魔族的复苏,骷髅拥有了生前的身体机能和原始的杀戮欲望.请勿必小心前行!";end;
		done_talk = function (npc,player,td) return "此洞原名罪恶坑,在远久的年代是一座用来处理战后士兵的乱葬洞.在近日随着魔族的复苏,骷髅拥有了生前的身体机能和原始的杀戮欲望.请勿必小心前行!";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★真是位热心的大叔...前方不远处就是骷髅洞了.★"); end;
	},
	[15	]={
		tid=15,		nid=16,		need_level=1,		name="阴兵重生",	accepter="玄空",	doner="澹台无月",
		need_type="mon",	need_target="地狱行者",		mon_map="v0099",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		drop_hook = {state=const.TSACED,mon="地狱行者",items={{name="试炼·靴",num=1},{name="试炼·戒",num=1}}},
		accept_talk = function (npc,player,td) return "好险啊,我差点就被骷髅的斧头砍中了!散架的骷髅还能再复原,真是恼死人了..小侠你快往前走,这里我暂时还挡得住";end;
		done_talk = function (npc,player,td) return "好险啊,我差点就被骷髅的斧头砍中了!散架的骷髅还能再复原,真是恼死人了..小侠你快往前走,这里我暂时还挡得住";end;
	},
	[16	]={
		tid=16,		nid=17,		need_level=1,		name="情报收集",	accepter="澹台无月",	doner="司空智",
		need_type="mon",	need_target="青铜幼兽",		mon_map="v0099",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		drop_hook = {state=const.TSACED,mon="青铜幼兽",items={{name="试炼·手",num=1},{name="试炼·靴",num=1}}},
		accept_talk = function (npc,player,td) return "小侠,想不到你竟有能力来到这洞穴深处.我是比奇城守卫队小队长玄战,此次陪同中大队长和武御史大人来收集魔族信息.";end;
		done_talk = function (npc,player,td) return "小侠,想不到你竟有能力来到这洞穴深处.我是比奇城守卫队小队长玄战,此次陪同中大队长和武御史大人来收集魔族信息.";end;

	},
	[17	]={
		tid=17,		nid=18,		need_level=1,		name="最后的骷髅兵种",	accepter="司空智",	doner="荆无病",
		need_type="fuben",		need_target="玄冰之路副本",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "持斧骷髅和大刀骷髅的情报收集好了,还差骷髅死侍和毒蝎.";end;
		done_talk = function (npc,player,td) return "持斧骷髅和大刀骷髅的情报收集好了,还差骷髅死侍和毒蝎.";end;
		done_hook = function (npc,player,td) posmap.fly(player,"新手大陆安全区") end;
	},
	[18	]={
		tid=18,		nid=19,		need_level=1,		name="惊魂一战",	accepter="荆无病",	doner="杜君淑",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "好生猛的骷髅死侍,快记下快记下!";end;
		done_talk = function (npc,player,td) return "好生猛的骷髅死侍,快记下快记下!";end;
	},
	[19	]={
		tid=19,		nid=20,		need_level=1,		name="最后的怪物",	accepter="杜君淑",	doner="刀无后",
		need_type="mon",	need_target="狗头战将",		mon_map="v0098",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="破甲·神兵",	num=1,itemId = 20001,flag=10,},	
		},
		accept_talk = function (npc,player,td) return "骷髅怪的信息都收集完了,就差毒蝎!前面不远处集中了一大群,个个个头巨大,千万要小心";end;
		done_talk = function (npc,player,td) return "骷髅怪的信息都收集完了,就差毒蝎!前面不远处集中了一大群,个个个头巨大,千万要小心";end;
		accept_hook =function (npc,player,td) posnpc.fly(player,"风泣血"); end;
	},
	[20	]={
		tid=20,		nid=21,		need_level=1,		name="准备回城",	accepter="刀无后",	doner="魔龙无忌",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "根据守卫们得到的情报分析,此地源源不断复活的骷髅应该是被一名通体腥红发亮的巨大骷髅复活并操纵.恐怕不干掉它,这里的白骨骷髅无法根除!好了,此地方不是谈话的地方,叫上前方公孙无忌大人一起回比奇城吧!大家站好了!传送法阵,开!";end;
		done_talk = function (npc,player,td) return "根据守卫们得到的情报分析,此地源源不断复活的骷髅应该是被一名通体腥红发亮的巨大骷髅复活并操纵.恐怕不干掉它,这里的白骨骷髅无法根除!好了,此地方不是谈话的地方,叫上前方公孙无忌大人一起回比奇城吧!大家站好了!传送法阵,开!";end;
	},
	[21	]={
		tid=21,		nid=22,		need_level=1,		name="初见BOSS",	accepter="魔龙无忌",	doner="萧瑟",
		need_type="mon",	need_target="沙怪",		mon_map="v0095",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "老夫果然没有看错人!你们这次带回的情报非常有用,魔物果然比上一次更加凶猛凌厉,看来苦境大陆要有一场苦战了!哎呀!你看我这把老骨头都忘了让你先去药店疗伤了!";end;
		done_talk = function (npc,player,td) return "老夫果然没有看错人!你们这次带回的情报非常有用,魔物果然比上一次更加凶猛凌厉,看来苦境大陆要有一场苦战了!哎呀!你看我这把老骨头都忘了让你先去药店疗伤了!";end;
	},
	[22	]={
		tid=22,		nid=23,		need_level=1,		name="免费治疗",	accepter="萧瑟",	doner="顾远",
		need_type="mon",	need_target="玄冥教徒",		mon_map="v0095",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "你是我们比奇城小英雄,这次疗伤自然是万万不能收费的啦!还请日后多多光临小店,不胜光荣.铸老似乎有些话要同你讲,去看看吧!";end;
		done_talk = function (npc,player,td) return "你是我们比奇城小英雄,这次疗伤自然是万万不能收费的啦!还请日后多多光临小店,不胜光荣.铸老似乎有些话要同你讲,去看看吧!";end;
	},
	[23	]={
		tid=23,		nid=24,		need_level=1,		name="成长密决",	accepter="顾远",	doner="意崎行",
		need_type="mon",	need_target="寒荒野人",		mon_map="v0095",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "一夜之间,僵尸洞,沃谷寺庙,蜈蚣洞,驽玛寺庙神迹般的突然出现在比奇边境,估计城里高层定会火速开展讨伐行会,你必须更好的成长起来!说到成长,好的装备是必不可少的,还要不断的为准备进行强化和合成以及晋升.";end;
		done_talk = function (npc,player,td) return "一夜之间,僵尸洞,沃谷寺庙,蜈蚣洞,驽玛寺庙神迹般的突然出现在比奇边境,估计城里高层定会火速开展讨伐行会,你必须更好的成长起来!说到成长,好的装备是必不可少的,还要不断的为准备进行强化和合成以及晋升.";end;
	},
	[24	]={
		tid=24,		nid=25,		need_level=1,		name="南伐开始",	accepter="意崎行",	doner="孤刀客",
		need_type="mon",	need_target="金刚尸煞",		mon_map="v0095",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "少侠你来啦!刚城主传下公告,即日起开始对比奇怪东南边境的僵尸发起反击!";end;
		done_talk = function (npc,player,td) return "少侠你来啦!刚城主传下公告,即日起开始对比奇怪东南边境的僵尸发起反击!";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★魔族还真是不给人喘息之机啊!★"); end;
	},
	[25	]={
		tid=25,		nid=26,		need_level=1,		name="行尸走肉",	accepter="孤刀客",	doner="左倾城",
		need_type="mon",	need_target="无常祭师",		mon_map="v0095",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "死而不化是为僵,行而无魂是为尸.这个洞里尸气冲天,定有尸王级别的金刚尸在此!少侠勿必小心行事.";end;
		done_talk = function (npc,player,td) return "死而不化是为僵,行而无魂是为尸.这个洞里尸气冲天,定有尸王级别的金刚尸在此!少侠勿必小心行事.";end;
	},
	[26	]={
		tid=26,		nid=27,		need_level=1,		name="痛饮",	accepter="左倾城",	doner="任飘渺",
		need_type="mon",	need_target="龙龟",		mon_map="v0095",	need_num=3,
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "生死线上走一遭, 方知酒浓.";end;
		done_talk = function (npc,player,td) return "生死线上走一遭, 方知酒浓.";end;
	},
	[27	]={
		tid=27,		nid=28,		need_level=1,		name="云淡风轻",	accepter="任飘渺",	doner="第一大陆传送员0",
		need_type="fuben",		need_target="古尘峰副本",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "生死线上走一遭, 方知酒浓.";end;
		done_talk = function (npc,player,td) return "生死线上走一遭, 方知酒浓.";end;
	},
	[28	]={
		tid=28,		nid=29,		need_level=1,		name="不服就干",	accepter="第一大陆传送员0",	doner="荆无病",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "不让路就相争啊, 男子汉大丈夫能动手就不要逼逼!";end;
		done_talk = function (npc,player,td) return "不让路就相争啊, 男子汉大丈夫能动手就不要逼逼!";end;
	},
	[29	]={
		tid=29,		nid=30,		need_level=1,		name="固若金汤",	accepter="荆无病",	doner="第二大陆传送员",
		need_type="mon", need_target="任意怪物", need_num=5, need_map="v0006", isMirror=true,
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=5},
		},
		accept_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
		done_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
		accepted_hook =function (npc,player,td) gui.PanelMaps.enterDengJiMap(player,50) end;
	},
	[30	]={
		tid=30,		nid=31,		need_level=1,		name="固若金汤",	accepter="荆无病",	doner="第二大陆传送员",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
		done_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
	},
	[31	]={
		tid=31,		nid=32,		need_level=1,		name="固若金汤",	accepter="第二大陆传送员",	doner="月灵犀",
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=5},
		},
		accept_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
		done_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
	},
	[32	]={
		tid=32,		nid=33,		need_level=1,		name="固若金汤",	accepter="月灵犀",	doner="逸无踪",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
		done_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
	},
	[33	]={
		tid=33,		nid=34,		need_level=1,		name="固若金汤",	accepter="逸无踪",	doner="逸无踪",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
		done_talk = function (npc,player,td) return "一夫当夫, 万夫莫开.";end;
	},
	[34	]={
		tid=34,		nid=35,		need_level=100,		name="等级达到100级",	accepter="荆无病",	doner="赛华佗",
		tuiJianToDo = pospanel.lua("gui.ItemSource.onPanelData",{cmd="alert",mType="uptolv100",itemName="等级丹(100级)"}), tuiJianText = "推荐：50级地图打怪",
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="等级丹(100级)", itemId = 10001,	num=5},
		},
		accept_talk = function (npc,player,td) return "武当出世, 必是魔祸天下之时!";end;
		done_talk = function (npc,player,td) return "武当出世, 必是魔祸天下之时!";end;
	},
	[35	]={
		tid=35,		nid=36,		need_level=1,		name="御神道符",	accepter="赛华佗",	doner="长风镖师",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "越往深处走尸气越重,恐怕非我道门中人难以抵抗.如果少侠执意要继续前行,请收下这张御神符吧,它可以帮你隐蔽半数生人气息,不易被僵尸察觉.";end;
		done_talk = function (npc,player,td) return "越往深处走尸气越重,恐怕非我道门中人难以抵抗.如果少侠执意要继续前行,请收下这张御神符吧,它可以帮你隐蔽半数生人气息,不易被僵尸察觉.";end;
	},
	[36	]={
		tid=36,		nid=37,		need_level=1,		name="道可道",	accepter="长风镖师",	doner="风泣血",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "人死后当入轮回,此乃天道.魔族之人实在可恶,我道门定与他们斗争到底...";end;
		done_talk = function (npc,player,td) return "人死后当入轮回,此乃天道.魔族之人实在可恶,我道门定与他们斗争到底...";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"继续深入"); end;
	},
	[37	]={
		tid=37,		nid=38,		need_level=1,		name="佛本是道",	accepter="风泣血",	doner="关易水",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "想不到连佛门圣气加持的前辈死后金身都要沦为魔族的傀儡,真是让人不胜嘘唏!";end;
		done_talk = function (npc,player,td) return "想不到连佛门圣气加持的前辈死后金身都要沦为魔族的傀儡,真是让人不胜嘘唏!";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★继续深入★"); end;
	},
	[38	]={
		tid=38,		nid=39,		need_level=1,		name="道家先天",	accepter="关易水",	doner="司徒堰",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "世间万物皆逃不过相生相克的法则,僵尸的天敌便是佛道之力,善于运用这两股力量,便可事半而功倍.";end;
		done_talk = function (npc,player,td) return "世间万物皆逃不过相生相克的法则,僵尸的天敌便是佛道之力,善于运用这两股力量,便可事半而功倍.";end;
	},
	[39	]={
		tid=39,		nid=40,		need_level=1,		name="腐烂源头",	accepter="司徒堰",	doner="云徽子",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "冥狱尸王把自己隐藏太好,短时间恐怕不易找到,我们会继续找寻,小侠你可先行回去比奇城把这里情况告知老兵.";end;
		done_talk = function (npc,player,td) return "冥狱尸王把自己隐藏太好,短时间恐怕不易找到,我们会继续找寻,小侠你可先行回去比奇城把这里情况告知老兵.";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★先行回到比奇城内.★"); end;
	},
	[40	]={
		tid=40,		nid=41,		need_level=1,		name="一体三化",		accepter="云徽子",	doner="清扫障碍1",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "猜猜我们是谁的化身!";end;
		done_talk = function (npc,player,td) return "猜猜我们是谁的化身!";end;
	},
	[41	]={
		tid=41,		nid=42,		need_level=1,		name="清扫障碍",	accepter="清扫障碍1",	doner="高天赐",
		need_type="const", need_target="完成一次清扫障碍任务", need_num=1, con=const.PP_RICHANG_NUM, task_target=pospanel.guide("task2000"),
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "猜猜我们是谁的化身!";end;
		done_talk = function (npc,player,td) return "猜猜我们是谁的化身!";end;
	},
	[42	]={
		tid=42,		nid=43,		need_level=1,		name="道教道主",	accepter="高天赐",	doner="笏少丞",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},


		accept_talk = function (npc,player,td) return "道消魔长, 魔消道长, 这无尽的轮回, 相辅相成.";end;
		done_talk = function (npc,player,td) return "道消魔长, 魔消道长, 这无尽的轮回, 相辅相成.";end;
	},
	[43	]={
		tid=43,		nid=44,		need_level=1,		name="人族之幸",	accepter="笏少丞",	doner="柳书言",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "幸有道门之助,僵尸之祸定会很快弥平.我想,也许你多了解上次人魔大战的一些信息会对你日后行动有所助益.去书店找组队探险吧,就说是老身介绍你去的.";end;
		done_talk = function (npc,player,td) return "幸有道门之助,僵尸之祸定会很快弥平.我想,也许你多了解上次人魔大战的一些信息会对你日后行动有所助益.去书店找组队探险吧,就说是老身介绍你去的.";end;
		killmon_complate_hook=function (npc,player,td) posnpc.fly(player,"比奇老兵");end;
	},
	[44	]={
		tid=44,		nid=45,		need_level=1,		name="人魔旧怨",	accepter="柳书言",	doner="清扫障碍1",
		award={
			{name="元宝", itemId = 19000,	num=1000},
			
		},

		accept_talk = function (npc,player,td) return "哈,小侠你来啦,乱世之中还愿意静下心来了解历史,实在难能可贵!魔族相关的书籍我已准备好,都放在左边,你自行翻阅吧,我便不打扰了!";end;
		done_talk = function (npc,player,td) return "哈,小侠你来啦,乱世之中还愿意静下心来了解历史,实在难能可贵!魔族相关的书籍我已准备好,都放在左边,你自行翻阅吧,我便不打扰了!";end;
		accept_hook =function (npc,player,td) player:alert(1,1,"★ 终于看完了,城里逛逛吧.★"); end;
	},
	[45	]={
		tid=45,		nid=46,		need_level=1,		name="国王召见",	accepter="清扫障碍1",	doner="50级地图",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "见过少侠,国王对于此次魔族复苏事件十分重视,有请阁下一见.";end;
		done_talk = function (npc,player,td) return "见过少侠,国王对于此次魔族复苏事件十分重视,有请阁下一见.";end;
		
	},
	[46	]={
		tid=46,		nid=47,		need_level=1,		name="穿2件10阶装备",	accepter="50级地图",	doner="回收员",
		need_type="equip", need_target="2件10阶装备", need_num=2, needEquipLv=10, tuiJianToDo = pospanel.lua("gui.ItemSource.onPanelData",{cmd="alert",mType="equiplv10",itemName="10阶装备"}), tuiJianText = "推荐：100级地图打怪",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "果真英雄出少年,寡人甚是欣慰,感谢你们带回来的骷髅洞和僵尸洞的情报.这是寡人命人特地为小侠量身定制的武器.";end;
		done_talk = function (npc,player,td) return "果真英雄出少年,寡人甚是欣慰,感谢你们带回来的骷髅洞和僵尸洞的情报.这是寡人命人特地为小侠量身定制的武器.";end;
	},
	[47	]={
		tid=47,		nid=48,		need_level=1,		name="感恩戴德",	accepter="回收员",	doner="军需官1",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "你为比奇做了很大的贡献,这是我们兄弟们为小侠准备的盔甲,祝你在战场所向披靡.";end;
		done_talk = function (npc,player,td) return "你为比奇做了很大的贡献,这是我们兄弟们为小侠准备的盔甲,祝你在战场所向披靡.";end;
		accepted_hook =function (npc,player,td) player:alert(1,1,"★比奇的人们真是客气,我得去别的魔族之地看看,不辜负大家的一番期待.★"); end;
	},
	[48	]={
		tid=48,		nid=49,		need_level=1,		name="变异的昆虫",	accepter="军需官1",	doner="关易水",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "这里的昆虫不知是受了什么力量的影响,体型变得异常巨人并凶残!";end;
		done_talk = function (npc,player,td) return "这里的昆虫不知是受了什么力量的影响,体型变得异常巨人并凶残!";end;
	},
	[49	]={
		tid=49,		nid=50,		need_level=110,		name="等级达到110级",	accepter="关易水",	doner="司徒堰",
		tuiJianToDo = pospanel.lua("gui.ItemSource.onPanelData",{cmd="alert",mType="uptolv150",itemName="等级丹(100级)"}), tuiJianText = "推荐：100级地图打怪<br/>          等级丹炼制",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "我长大这么大最多只见过拳头大的虫子, 居然还有人大的虫子!";end;
		done_talk = function (npc,player,td) return "我长大这么大最多只见过拳头大的虫子, 居然还有人大的虫子!";end;
	},
	[50	]={
		tid=50,		nid=51,		need_level=1,		name="天之痕",	accepter="司徒堰",	doner="云徽子",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "吾夜观星象, 魔族的力量空前强大, 就连天际都快被其冲出一道裂痕.";end;
		done_talk = function (npc,player,td) return "吾夜观星象, 魔族的力量空前强大, 就连天际都快被其冲出一道裂痕.";end;
	},
	[51	]={
		tid=51,		nid=52,		need_level=1,		name="更多的势力",	accepter="云徽子",	doner="100级地图",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "想不到此次竟连昆虫也加入战斗,可以想象得到今次人魔大战的惨烈程度必定更胜以往!那个圆滚滚的东西,速度奇快,一旦见到人就必定缠斗至死,记住,如果遇到了不要想着逃跑,拼命一搏的希望反而更大些!";end;
		done_talk = function (npc,player,td) return "想不到此次竟连昆虫也加入战斗,可以想象得到今次人魔大战的惨烈程度必定更胜以往!那个圆滚滚的东西,速度奇快,一旦见到人就必定缠斗至死,记住,如果遇到了不要想着逃跑,拼命一搏的希望反而更大些!";end;
	},
	[52	]={
		tid=52,		nid=53,		need_level=1,		name="避不开的麻烦",	accepter="100级地图",	doner="第二大陆传送员",
		need_type="mon", need_target="任意怪物", need_num=5, need_map="v0007", isMirror=true,
		award={
			{name="元宝", itemId = 19000,	num=1000},
			{name="天魔项链",	num=1,job='warrior',  itemId = 70008,flag=10,},
			{name="法神项链",	num=1,job='wizard',   itemId = 70009,flag=10,},
			{name="天尊项链",	num=1,job='taoist',   itemId = 70010,flag=10,},
		},
		accept_talk = function (npc,player,td) return "被那么多的黑暗恶蛆看上,还真是难为少侠了!";end;
		done_talk = function (npc,player,td) return "被那么多的黑暗恶蛆看上,还真是难为少侠了!";end;
		accepted_hook =function (npc,player,td) gui.PanelMaps.enterDengJiMap(player,100) end;
	},
	[53	]={
		tid=53,		nid=54,		need_level=1,		name="百毒不侵",	accepter="第二大陆传送员",	doner="赛华佗",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "没想到平时看上去呆萌呆萌的蹦蹦虫巨化数百倍之后竟然如此可怕渗人!少侠也来一瓶我神谷峰的冥神蛊吧,可保你在战斗中不会中毒!";end;
		done_talk = function (npc,player,td) return "没想到平时看上去呆萌呆萌的蹦蹦虫巨化数百倍之后竟然如此可怕渗人!少侠也来一瓶我神谷峰的冥神蛊吧,可保你在战斗中不会中毒!";end;
	},
	[54	]={
		tid=54,		nid=55,		need_level=1,		name="青色巨虫",	accepter="赛华佗",	doner="100级地图",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "带两张皮回去研究研究,说不定能解开昆虫巨化之迷.";end;
		done_talk = function (npc,player,td) return "带两张皮回去研究研究,说不定能解开昆虫巨化之迷.";end;
	},
	[55	]={
		tid=55,		nid=56,		need_level=120,		name="等级达到120级",	accepter="100级地图",	doner="回收员",
		tuiJianToDo = pospanel.lua("gui.ItemSource.onPanelData",{cmd="alert",mType="uptolv150",itemName="等级丹(100级)"}), tuiJianText = "推荐：100级地图打怪<br/>          等级丹炼制",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "这些虫子的甲壳异常坚硬,想不到少侠竟如此神勇,当真是苦境之幸!";end;
		done_talk = function (npc,player,td) return "这些虫子的甲壳异常坚硬,想不到少侠竟如此神勇,当真是苦境之幸!";end;
	},
	[56	]={
		tid=56,		nid=57,		need_level=1,		name="数量优势",	accepter="回收员",	doner="神行无迹",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "这里的虫子虽然在魔族中算不上高级, 但数量上却优势明显, 不可小觑!";end;
		done_talk = function (npc,player,td) return "这里的虫子虽然在魔族中算不上高级, 但数量上却优势明显, 不可小觑!";end;
	},
	[57	]={
		tid=57,		nid=58,		need_level=1,		name="蝗虫过境",	accepter="神行无迹",	doner="北辰泓",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "若让这些虫子跑去洞外, 肯定寸草不生!";end;
		done_talk = function (npc,player,td) return "若让这些虫子跑去洞外, 肯定寸草不生!";end;
	},
	[58	]={
		tid=58,		nid=59,		need_level=1,		name="乐者",	accepter="北辰泓",	doner="回收员",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},


		accept_talk = function (npc,player,td) return "一曲天波浩渺, 谢过小侠救世善行.";end;
		done_talk = function (npc,player,td) return "一曲天波浩渺, 谢过小侠救世善行.";end;
	},
	[59	]={
		tid=59,		nid=60,		need_level=1,		name="玄妙",	accepter="回收员",	doner="魔窟先锋",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "我已勘破魔祸, 不过天机不可泄漏...";end;
		done_talk = function (npc,player,td) return "我已勘破魔祸, 不过天机不可泄漏...";end;
	},
	[60	]={
		tid=60,		nid=61,		need_level=1,		name="醉生梦死",	accepter="魔窟先锋",	doner="第二大陆传送员",
		need_type="equip", need_target="5件10阶装备", need_num=5, needEquipLv=10, tuiJianToDo = pospanel.lua("gui.ItemSource.onPanelData",{cmd="alert",mType="equiplv10",itemName="10阶装备"}), tuiJianText = "推荐：100级地图打怪<br/>          首冲活动<br/>          神装优惠",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "世人皆醉同, 唯我独醒.";end;
		done_talk = function (npc,player,td) return "世人皆醉同, 唯我独醒.";end;
	},
	[61	]={
		tid=61,		nid=62,		need_level=1,		name="浮生若梦",	accepter="第二大陆传送员",	doner="荆无病",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "这纷扰乱世, 能醉着过日子, 何尝不是一种奢侈.";end;
		done_talk = function (npc,player,td) return "这纷扰乱世, 能醉着过日子, 何尝不是一种奢侈.";end;
		accept_hook = function (npc,player,td) posnpc.fly(player,"药店夜愁雨");end;
	},
	[62	]={
		tid=62,		nid=63,		need_level=1,		name="试验",	accepter="荆无病",	doner="杜君淑",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "如果魔族把巨化昆虫的手段用来人身上, 会怎么样呢?";end;
		done_talk = function (npc,player,td) return "如果魔族把巨化昆虫的手段用来人身上, 会怎么样呢?";end;
	},
	[63	]={
		tid=63,		nid=64,		need_level=1,		name="威胁消弥",	accepter="杜君淑",	doner="月灵犀",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "经过大家的牺牲和努力,巨虫对人族已构不成威胁,小侠你回比奇城看看还没有别的任务吧!";end;
		done_talk = function (npc,player,td) return "经过大家的牺牲和努力,巨虫对人族已构不成威胁,小侠你回比奇城看看还没有别的任务吧!";end;
		-- complate_hook = function(npc,player,td) util.openPanel(player,"Panel_recycle",{guide="huishou"}) end
	},
	[64	]={
		tid=64,		nid=65,		need_level=1,		name="圣华之盾",	accepter="月灵犀",	doner="风泣血",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "他强任他强, 清风指山岗; 他横由他横, 明月照大江.";end;
		done_talk = function (npc,player,td) return "他强任他强, 清风指山岗; 他横由他横, 明月照大江.";end;
	},
	[65	]={
		tid=65,		nid=66,		need_level=1,		name="真正英雄",	accepter="风泣血",	doner="第二大陆传送员",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "少侠好气魄! 果真乱世出英雄!";end;
		done_talk = function (npc,player,td) return "少侠好气魄! 果真乱世出英雄!";end;
	},
	[66	]={
		tid=66,		nid=67,		need_level=150,		name="等级达到150级",	accepter="第二大陆传送员",	doner="清扫障碍1",dir_fly=true,
		tuiJianToDo = pospanel.lua("gui.ItemSource.onPanelData",{cmd="alert",mType="uptolv150",itemName="等级丹(100级)"}), tuiJianText = "推荐：100级地图打怪<br/>          等级丹炼制",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "新的战场转移到了沃谷寺庙,小侠稍做准备,我们不日后便出发!";end;
		done_talk = function (npc,player,td) return "新的战场转移到了沃谷寺庙,小侠稍做准备,我们不日后便出发!";end;
	},
	[67	]={
		tid=67,		nid=68,		need_level=60,		name="有缘再会",	accepter="清扫障碍1",	doner="柳书言",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "比奇城的兵力和资源都调往四方边境,我们能做的就是站在魔族的尸体上接受仰望或马革裹尸战死沙场.沃谷寺庙的入口就在前方,祝少侠此去平安.有缘再会!";end;
		done_talk = function (npc,player,td) return "比奇城的兵力和资源都调往四方边境,我们能做的就是站在魔族的尸体上接受仰望或马革裹尸战死沙场.沃谷寺庙的入口就在前方,祝少侠此去平安.有缘再会!";end;
	},
	[68	]={
		tid=68,		nid=69,		need_level=1,		name="恶臭难当",	accepter="柳书言",	doner="除魔道人1",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "前方有一堆恶臭怪虫,我都快打不下去了!小侠帮帮忙开条道出来吧!万分感谢.";end;
		done_talk = function (npc,player,td) return "前方有一堆恶臭怪虫,我都快打不下去了!小侠帮帮忙开条道出来吧!万分感谢.";end;
	},
	[69	]={
		tid=69,		nid=70,		need_level=1,		name="继续前行",	accepter="除魔道人1",	doner="笏少丞",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "小侠的勇气我是服的!咱们继续往前推进吧!";end;
		done_talk = function (npc,player,td) return "小侠的勇气我是服的!咱们继续往前推进吧!";end;
	},
	[70	]={
		tid=70,		nid=71,		need_level=1,		name="骁勇战将",	accepter="笏少丞",	doner="生肖地图1",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "这些沃谷勇士拥有牛的力量和人的智商,我觉得我们可能需要援助.前面的火牛似乎还拥有着杰出的火系魔法和抗性,小侠当心了!";end;
		done_talk = function (npc,player,td) return "这些沃谷勇士拥有牛的力量和人的智商,我觉得我们可能需要援助.前面的火牛似乎还拥有着杰出的火系魔法和抗性,小侠当心了!";end;
	},
	[71	]={
		tid=71,		nid=72,		need_level=1,		name="热!热!热!",	accepter="生肖地图1",	doner="150级地图",
		award={
			{name="元宝", itemId = 19000,	num=1000},
			
		},

		accept_talk = function (npc,player,td) return "可算搞定了,再晚点我可就要被烤熟了!为难了水属性的我!赶紧干掉最后一批沃谷战士,我要回比奇城洗澡!";end;
		done_talk = function (npc,player,td) return "可算搞定了,再晚点我可就要被烤熟了!为难了水属性的我!赶紧干掉最后一批沃谷战士,我要回比奇城洗澡!";end;
	},
	[72	]={
		tid=72,		nid=73,		need_level=1,		name="穿2件15阶装备",	accepter="150级地图",	doner="赛华佗",
		need_type="equip", need_target="2件15阶装备", need_num=2, needEquipLv=15, tuiJianToDo = pospanel.lua("gui.ItemSource.onPanelData",{cmd="alert",mType="equiplv15",itemName="15阶装备"}), tuiJianText = "推荐：150级地图打怪<br/>          首冲活动<br/>          神装优惠",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "数日不见,小侠似乎变得更加成熟了,想来这次沃谷之行经历了不少!快去城市多转悠会,好好享受这暂时的闲暇吧!";end;
		done_talk = function (npc,player,td) return "数日不见,小侠似乎变得更加成熟了,想来这次沃谷之行经历了不少!快去城市多转悠会,好好享受这暂时的闲暇吧!";end;
	},
	[73	]={
		tid=73,		nid=74,		need_level=1,		name="风月流光",	accepter="赛华佗",	doner="长风镖师",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},


		accept_talk = function (npc,player,td) return "窈窕淑女, 君子好逑, 人不风流枉少年, 小青年喜欢妙女子何错之有?";end;
		done_talk = function (npc,player,td) return "窈窕淑女, 君子好逑, 人不风流枉少年, 小青年喜欢妙女子何错之有?";end;
		accept_hook = function (npc,player,td) posnpc.fly(player,"比奇老兵");end;
	},
	[74	]={
		tid=74,		nid=75,		need_level=1,		name="失联的夫君",	accepter="长风镖师",	doner="风泣血",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},

		accept_talk = function (npc,player,td) return "少侠,我夫君谢岚去猪洞去,失去了联系.如果你下次去执行任务,请必务帮忙留意下他的下落,小女子在此先谢过了!";end;
		done_talk = function (npc,player,td) return "少侠,我夫君谢岚去猪洞去,失去了联系.如果你下次去执行任务,请必务帮忙留意下他的下落,小女子在此先谢过了!";end;
	},
	[75	]={
		tid=75,		nid=76,		need_level=1,		name="新的战场",	accepter="风泣血",	doner="关易水",
		award={
			{name="元宝", itemId = 19000,	num=1000},		
		},
		accept_talk = function (npc,player,td) return "比奇边境的危机基本已经控制,少侠也是出了不少力,我在此谢过了!人魔大战的主战场荒漠土城现在急需少侠这样的英雄!";end;
		done_talk = function (npc,player,td) return "比奇边境的危机基本已经控制,少侠也是出了不少力,我在此谢过了!人魔大战的主战场荒漠土城现在急需少侠这样的英雄!";end;
	},
	[76	]={
		tid=76,		nid=77,		need_level=1,		name="荒漠中的城市",	accepter="关易水",	doner="第二大陆传送员",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "少侠一路奔波,辛苦了,请先在土城熟悉下环境稍做休息.咱土城不比比奇城那样的大都市,尤其缺乏水资源.";end;
		done_talk = function (npc,player,td) return "少侠一路奔波,辛苦了,请先在土城熟悉下环境稍做休息.咱土城不比比奇城那样的大都市,尤其缺乏水资源.";end;
	},
	[77	]={
		tid=77,		nid=78,		need_level=200,		name="等级达到200级",	accepter="第二大陆传送员",	doner="回收员",
		tuiJianToDo = pospanel.lua("gui.ItemSource.onPanelData",{cmd="alert",mType="uptolv200",itemName="等级丹(100级)"}), tuiJianText = "推荐：150级地图打怪<br/>          等级丹炼制<br/>          勇闯魔窟",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "哟,那边的少侠,要来点啥吗?我这里回城石,随机石等等应有应有尽有...额,只是路过啊,不好意思...";end;
		done_talk = function (npc,player,td) return "哟,那边的少侠,要来点啥吗?我这里回城石,随机石等等应有应有尽有...额,只是路过啊,不好意思...";end;
	},
	[78	]={
		tid=78,		nid=79,		need_level=1,		name="惜英雄",	accepter="回收员",	doner="通天塔守卫",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "你好,听说你就是近期在比奇城小有名气的侠士["..player:get_name().."],久仰!";end;
		done_talk = function (npc,player,td) return "你好,听说你就是近期在比奇城小有名气的侠士["..player:get_name().."],久仰!";end;
	},
	[79	]={
		tid=79,		nid=80,		need_level=1,		name="恻隐之心",	accepter="通天塔守卫",	doner="神行无迹",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "少年人行行好吧,尝点小钱买个馍馍,我已经饿了3天没有吃过东西了!...谢谢小爷,谢谢小爷,您一定会好人有好报的!";end;
		done_talk = function (npc,player,td) return "少年人行行好吧,尝点小钱买个馍馍,我已经饿了3天没有吃过东西了!...谢谢小爷,谢谢小爷,您一定会好人有好报的!";end;
	},
	[80	]={
		tid=80,		nid=81,		need_level=1,		name="讨厌的飞虫",	accepter="神行无迹",	doner="第二大陆传送员",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "你是从比奇城来的援兵吗?先帮我消灭一些幺蛾吧!";end;
		done_talk = function (npc,player,td) return "你是从比奇城来的援兵吗?先帮我消灭一些幺蛾吧!";end;
	},
	[81	]={
		tid=81,		nid=1000,		need_level=300,		name="等级达到300级",	accepter="第二大陆传送员",	doner="第二大陆传送员",
		tuiJianToDo = pospanel.lua("gui.ItemSource.onPanelData",{cmd="alert",mType="uptolv300",itemName="等级丹(100级)"}), tuiJianText = "推荐：250级地图打怪<br/>          等级丹炼制<br/>          勇闯魔窟",
		award={
			{name="元宝", itemId = 19000,	num=1000},
		},
		accept_talk = function (npc,player,td) return "少侠果真气度非凡, 人中龙凤, 在下实在有幸有幸.";end;
		done_talk = function (npc,player,td) return "少侠果真气度非凡, 人中龙凤, 在下实在有幸有幸.";end;
		
	},
};

function getTaskData()
	return task_data
end

local task_state_data={};
function showTaskInfo(player)
	return task.util.show_task_info(player,player,task_id,task_state_data,task_data);
end

function onGetTaskShortDesp(player)		task.util.show_task_short_desp(player,player,task_id,task_state_data,task_data);end

function show_task(npc,player)			task.util.show_main_task_talk(npc,player,task_id,task_state_data,task_data);end

function get_npc_flags(npc,player)		return task.util.get_npc_flags(npc,player,task_id,task_state_data,task_data);end

function check_mon_kill(player,mon)		check_mon_kill_task_drop(player,mon); task.util.check_mon_kill(player,mon,task_id,task_state_data,task_data);end
function check_item_change(player,i_name,i_id)	task.util.check_item_change(player,i_name,i_id,task_id,task_state_data,task_data);end
function check_level(player,lv)			task.util.check_level(player,lv,task_id,task_state_data,task_data);end
function check_const_change(player,con) task.util.check_const_change(player,con,task_id,task_state_data,task_data) end
function check_mon_caiji(player,mon,group)
	if group then return;end;
end
ckmon.add_caiji_listener("霜草",check_mon_caiji);

function check_task_done(player,panel_name)
	local s = player:get_task_state(task_id);
	local b = math.floor(s / const.TASK_STATE_NUM);
	local d = math.fmod(s,const.TASK_STATE_NUM);
	local k = task_data[b]
	if k then
		if d == const.TSACED then
			if k.need_type == "panel" or k.need_type == "fuben" or k.need_type == "equip" or k.need_type == "elitemon"  then
				if k.need_target == panel_name then
					player:set_task_param(task_id,1,player:get_task_param(task_id,1)+1);
					if player:get_task_param(task_id,1) >= k.need_num then
						if k.need_target == "击败天神殿" then player:alert(1,1,"[击败天神殿任务]已经完成!");end;
						player:set_task_state(task_id,task.util.ts(k.tid,const.TSCOMP));
						if k.complate_hook then k.complate_hook(npc,player,k);end;
						if task_data.autogo and (not k.noautogo) then
							posnpc.go(player,k.doner);
						end	
					elseif k.need_target == "击败天神殿" then
						player:alert(1,1,"[击败天神殿任务]当前击败了"..player:get_task_param(task_id,1).."/"..k.need_num.."天神殿怪物!")	
					end
					player:push_task_data(task_id,0);
					if k.need_target == "个人首领" then
						player:set_param(const.PP_MAINTASK_BOSS, 3)
					end
					cktask.triger_task_change(player,task_id)
				end
			end
		end
	end
end

function startkuang(player,mon)
	player:start_progress_bar(mon:get_caiji_duration(),"正在采集中...");
end
function startbuzhuo(player,mon)
	player:start_progress_bar(mon:get_caiji_duration(),"正在捕捉中...");
end
ckmon.add_caijistart_listener("霜草",startkuang);
ckmon.add_caijistart_listener("铁矿",startkuang);
ckmon.add_caijistart_listener("鱼1",startbuzhuo);

_M['onTalkT'..task_id..'Show']=function (npc,player) task.util.show_main_task_talk(npc,player,task_id,task_state_data,task_data); end
_M['onTalkT'..task_id..'Do']=function (npc,player) return task.util.task_done(npc,player,task_id,task_state_data,task_data); end

for i=1,#task_data do
	if task_data[i] then
		task.util.build_task_state(task_id,task_data[i],task_data,task_state_data);
		if task_data[i].need_type == "mon" then
			ckmon.add_all_listener(check_mon_kill);
		end
		if task_data[i].need_type == "item" then
			ckitem.add_listener(task_data[i].need_item,check_item_change);
		end
		if task_data[i].need_type == "const" and task_data[i].con then
			cktask.add_const_listener(check_const_change,task_data[i].con)
		end
	end
end;
cklevel.add_listener(check_level);
--for i=1,100 do if _M['init_task_'..i] then _M['init_task_'..i](); end; end;

function first_login(player)
	player:set_task_state(task_id,task.util.ts(1,const.TSACCE));
	player:push_task_data(task_id,1);
end
login.add_first_login_listener(first_login);

function daily_task_login(player)
	local s = player:get_task_state(task_id);
	local b = math.floor(s / const.TASK_STATE_NUM);
	local d = math.fmod(s,const.TASK_STATE_NUM);
	local td = task_data[b]
	if td then
		if d == const.TSACED then
			if not td.need_type or td.need_type == "fuben" then
				player:set_task_state(task_id,task.util.ts(b,const.TSCOMP));
				player:push_task_data(task_id,0);
			else
				if td.need_num then
					local tsp = tonumber(player:get_task_param(task_id,1)) or 0
					if tsp >= td.need_num then
						player:set_task_state(task_id,task.util.ts(b,const.TSCOMP));
						player:push_task_data(task_id,0);
					end
				end
			end
		end
	end
	if d == const.TSPASS then
		if b < #task_data then
			if task_data[td.nid] then
				player:set_task_state(task_id,task.util.ts(td.nid,const.TSUNAC));
				if (task_data[td.nid].need_level and player:get_level() >= task_data[td.nid].need_level) or(task_data[td.nid].need_zslevel and util.ppn(player,const.PP_ZHSH_LEVEL) >= task_data[td.nid].need_zslevel) then
					player:set_task_state(task_id,task.util.ts(td.nid,const.TSACCE));
				end
				player:push_task_data(task_id,0);
				cktask.triger_task_change(player,task_id)
			end
		end
	end
end
login.add_login_listener(daily_task_login);

function finishCurTask(player,forcemove)
	local s = player:get_task_state(task_id);
	local b = math.floor(s / const.TASK_STATE_NUM);
	local d = math.fmod(s,const.TASK_STATE_NUM);
	local td = task_data[b]
	player:set_task_param(task_id,1,td.need_num or 1);
	if td.kill_talk then td.kill_talk(player,td) end
	if player:get_task_param(task_id,1) >= (td.need_num or 1) then
		player:set_task_state(task_id,task.util.ts(td.tid,const.TSCOMP));
		if forcemove and td.complate_hook then td.complate_hook(npc,player,td);end;
		if forcemove and td.killmon_complate_hook then td.killmon_complate_hook(npc,player,td);end;
		if task_data.autogo and (not td.noautogo) then
			local map = player:get_map()
			if map then
				local mapID = map:get_id()
				if not util.isFuben(mapID) then
					posnpc.go(player,td.doner,320)
				end
			end 
		end
		player:refresh_npc_show_flags_inview();
		-- if td.focus then focus.f(player,"mini_task");end
		cktask.triger_task_change(player,task_id)
	end
	player:push_task_data(task_id,0);
end

function checkFubenFinishTask(player,forcemove)
	local s = player:get_task_state(task_id);
	local b = math.floor(s / const.TASK_STATE_NUM);
	local d = math.fmod(s,const.TASK_STATE_NUM);
	local td = task_data[b]
	if td then
		if td.need_type == "fuben" then
			local pData = pospanel.getData(td.need_target)
			if pData and util.isInMap(player,pData.map_pre) then
				--- 第二个参数 forcemove 限制调用此方法的所有入口 在onPlayerLeave调用的时候 禁止再次切换地图
				finishCurTask(player,forcemove)
				return true
			end
		end
	end
	return false
end

function checkWearEquipFinishTask(player,flag)
	local s = player:get_task_state(task_id);
	local b = math.floor(s / const.TASK_STATE_NUM);
	local d = math.fmod(s,const.TASK_STATE_NUM);
	local td = task_data[b]
	if td then
		if td.need_type == "equip" then
			local needEquipLv = td.needEquipLv or 0
			local needNum = td.need_num or 0
			local hasNum = 0
			for k,v in ipairs(equip.BodyBasePoses) do
				local itemBdP = util.getItemMiniBaseDataByPos(player,v)
				if itemBdP then
					local itemBd = util.getItemMiniBaseData(player,itemBdP.mTypeID)
					if itemBd and itemBd.mEquipLv >= needEquipLv then
						hasNum = hasNum + 1
						if hasNum >= needNum then
							break
						end
					end
				end
			end
			if hasNum >= needNum then
				if flag and flag == 1 then
					return 1
				end
				finishCurTask(player,true)
				return 2
			end
		end
	end
	return 0
end

function delayContinueTask(player,delay)
	delay = delay or 0.1
	player:set_timer(15,delay*1000)
end

function getTaskState(player)
	local s = player:get_task_state(task_id);
	local b = math.floor(s / const.TASK_STATE_NUM);
	local d = math.fmod(s,const.TASK_STATE_NUM);
	return d,b,task_data[b]
end

function check_mon_kill_task_drop(player,mon)
	local dFlag = util.ppn(player,const.PP_TASK_DROP_FLAG)
	if dFlag == 0 then
		local state,ind,td = getTaskState(player)
		if td and td.drop_hook then
			if state == (td.drop_hook.state or const.TSACED) then
				local mmp = player:get_map()
				if mmp then
					local mx,my = mon:get_pos()
					for k,v in ipairs(td.drop_hook.items) do
						mmp:drop_item(v.name,0,mx,my,player:get_id(),v.num,180,0,0)
					end
					player:set_param(const.PP_TASK_DROP_FLAG,1)
				end
			end
		end
	end
end

function onTaskChange(player,tid)
	if tid == task_id then
		local dFlag = util.ppn(player,const.PP_TASK_DROP_FLAG)
		if dFlag ~= 0 then
			local state,ind,td = getTaskState(player)
			if td then
				if td.drop_hook then
					if state == (td.drop_hook.state or const.TSACED) then
						player:set_param(const.PP_TASK_DROP_FLAG,0)
					end
				end
			end
		end
	end
end
cktask.add_listener(onTaskChange)


