module(..., package.seeall)
--清扫障碍

local ServerLua = (...)..".onPanelData"
local task_id=const.TASK_ID_RICHANG;
local NeedLv = 50  --开放等级
local TASK_MAX_NUM = 10
local TASK_MAX_STAR = 10
local FreshNeed = 10000  --刷新消耗数量
local FastDoneNeed = 100 --直接完成消耗金钻数量
local BuyTaskNeed = 100  --购买一次任务次数消耗金钻数量
local TASK_NAME = "清扫障碍"
local TASK_NPC = "清扫障碍1"
local task_data={
	ttype="日常",		focus=false,		autogo=false, getTaskTarget = function(player,td) return pospanel.lua("player.onPanelData",{cmd="promptPosnpc",fly=td.doner,okTitle="立即前往",desp="您已完成当前<font color='#00FF00'>清扫障碍任务</font>，是否前往提交任务？"}) end;
	[1]={need_level=50,		max_level=100,		need_target="",	need_map="v010", need_num=20,},
	[2]={need_level=100,	max_level=200,	need_target="",	need_map="v008", need_num=25,},
	[3]={need_level=200,	max_level=300,		need_target="",	need_map="v012", need_num=30,},
	[4]={need_level=300,	max_level=400,		need_target="",	need_map="v014", need_num=30,},
	[5]={need_level=400,	max_level=500,		need_target="",	need_map="v016", need_num=30,},
	[6]={need_level=500,	max_level=600,		need_target="",	need_map="v018", need_num=30,},
	[7]={need_level=600,	max_level=700,		need_target="",	need_map="v103", need_num=30,},
	[8]={need_level=700,	max_level=800,		need_target="",	need_map="v105", need_num=30,},
	[9]={need_level=800,	max_level=1000000,	need_target="",	need_map="v101", need_num=30,},
};
--不同星级对应奖励数量
local AwardData = {
	[0] = {{name="护符碎片(中)",num=1,bFlag=1},{name="元宝",num=5000}},
	[1] = {{name="护符碎片(中)",num=1,bFlag=1},{name="元宝",num=1000}},
	[2] = {{name="护符碎片(中)",num=1,bFlag=1},{name="元宝",num=1500}},
	[3] = {{name="护符碎片(中)",num=1,bFlag=1},{name="元宝",num=2000}},
	[4] = {{name="护符碎片(中)",num=1,bFlag=1},{name="元宝",num=2500}},
	[5] = {{name="护符碎片(中)",num=1,bFlag=1},{name="元宝",num=3000}},
	[6] = {{name="护符碎片(中)",num=2,bFlag=1},{name="元宝",num=3500}},
	[7] = {{name="护符碎片(中)",num=2,bFlag=1},{name="元宝",num=4000}},
	[8] = {{name="护符碎片(中)",num=2,bFlag=1},{name="元宝",num=4500}},
	[9] = {{name="护符碎片(中)",num=2,bFlag=1},{name="元宝",num=5000}},
	[10] = {{name="护符碎片(中)",num=3,bFlag=1},{name="元宝",num=55000}},
}
--多倍领取消耗金钻配置
local LingQuData = {
	[1] = {mul=1,need=0,name="金钻",desp="免费领取"},
	[2] = {mul=2,need=500,name="金钻",desp="两倍领取"},
	[3] = {mul=3,need=1000,name="金钻",desp="三倍领取"},
}
--刷新概率配置
local FreshPro = {
	[1] = {pro=1000,star=5},
	[2] = {pro=2500,star=6},
	[3] = {pro=4000,star=7},
	[4] = {pro=6000,star=8},
	[5] = {pro=8000,star=9},
	[6] = {pro=10000,star=10},
}

local task_state_data={};
for i=1,#task_data do
	task_data[i].tid=i;task_data[i].nid=i;
	task_data[i].name=TASK_NAME;
	task_data[i].accepter=TASK_NPC;
	task_data[i].doner=TASK_NPC;
	task_data[i].need_type="mon";
	task_data[i].kill_talk=function (player,td) player:alert(1,0,"清扫障碍："..player:get_task_param(task_id,1).."/"..td.need_num) end
	task_data[i].complate_hook=function(n,player,td) 
		util.prompt(player,{msg="您已完成当前<font color='#00FF00'>清扫障碍任务</font>，是否前往提交任务？",okTitle="立即前往",actionData={src="player.onPanelData",data={cmd="posnpc",fly=td.doner}}})
	 end
	-- task_data[i].accept_hook=function (npc,player,td) posmon.fly(player,td.need_target); end;
end

function onGetTaskShortDesp(player)		task.util.show_task_short_desp(player,player,task_id,task_state_data,task_data);end
function check_mon_kill(player,mon)		task.util.check_mon_kill(player,mon,task_id,task_state_data,task_data);end
function check_item_change(player,i_name,i_id)	task.util.check_item_change(player,i_name,i_id,task_id,task_state_data,task_data);end

_M['onTalkT'..task_id..'Show']=function (npc,player) task.util.show_task_talk(npc,player,task_id,task_state_data,task_data); end
_M['onTalkT'..task_id..'Do']=function (npc,player) return task.util.task_done(npc,player,task_id,task_state_data,task_data); end

for i=1,#task_data do
	local td = task_data[i];
	task.util.build_task_state(task_id,task_data[i],task_data,task_state_data);
	if task_data[i].need_type == "mon" then
		ckmon.add_all_listener(check_mon_kill);
	end
	if task_data[i].need_type == "item" then
		ckitem.add_listener(task_data[i].need_item,check_item_change);
	end
	task_state_data[task.util.ts(td.tid,const.TSACCE)].done2 = task_state_data[task.util.ts(td.tid,const.TSACCE)].done;
	task_state_data[task.util.ts(td.tid,const.TSACCE)].done=function(npc,player)
		if util.ppn(player,const.PP_RICHANG_NUM) < const.RICHANG_MAX_NUM + util.ppn(player,const.PP_RICHANG_BUYNUM) then
			-- player:set_param(const.PP_RICHANG_NUM,util.ppn(player,const.PP_RICHANG_NUM)+1);
			return task_state_data[task.util.ts(td.tid,const.TSACCE)].done2(npc,player);
		else
			player:set_task_state(task_id,task.util.ts(td.tid,const.TSUNAC));
			player:push_task_data(task_id,0);
			player:alert(1,0,"对不起,您今天的清扫障碍任务已经全部完成!");
			return 100;
		end
	end
	task_state_data[task.util.ts(td.tid,const.TSACED)].on_mon_kill =function (mon,player,group) 
		if string.gsub(mon:get_name(),"%d+$","") == td.need_target or util.isInMap(player,td.need_map) then
			if td.maptype and td.maptype == "fuben" then--------清扫障碍进副本
				if td.need_map and nil == string.find(mon:get_map():get_id(),td.need_map) then
					return ;
				end
				if player:get_map():num_monster() <= 0 then -- 怪物清完
					player:set_task_state(task_id,task.util.ts(td.tid,const.TSCOMP));
					if td.complate_hook then td.complate_hook(npc,player,td);end;
					if task_data.autogo and (not td.noautogo) then posnpc.go(player,td.doner);end
					--gui.moduleRedPoint.checkChumoAwardUsable(player)
				end 
			else
				if td.need_map and not string.find(mon:get_map():get_id(),td.need_map) then return end
				player:set_task_param(task_id,1,player:get_task_param(task_id,1)+1);
				if td.kill_talk then td.kill_talk(player,td) end
				if player:get_task_param(task_id,1) >= td.need_num then
					player:set_task_state(task_id,task.util.ts(td.tid,const.TSCOMP));
					if td.complate_hook then td.complate_hook(npc,player,td);end;
					if task_data.autogo and (not td.noautogo) then posnpc.go(player,td.doner);end
				end
			end
			player:push_task_data(task_id,0);
		end
		
		player:push_task_data(task_id,0);
	end;
	task_state_data[task.util.ts(td.tid,const.TSCOMP)].alltalk=function (target,player,n)
		local s=player:get_task_state(task_id);
		local b=math.floor(s / const.TASK_STATE_NUM);
		local d=math.fmod(s,const.TASK_STATE_NUM);
		local k = task_state_data[task.util.ts(td.tid,const.TSCOMP)];
		task.util.show_task_type(target,player,task_id,task_data);
		task.util.show_task_name(target,player,task_id,task_data);
		if n.award then
			task.util.show_award(target,player,n.award);
		end
		return 1;
	end;
	task_state_data[task.util.ts(td.tid,const.TSCOMP)].shortdesp=posnpc.fp(td.doner);
	task_state_data[task.util.ts(td.tid,const.TSCOMP)].done=function (npc,player)
		local ret=100;
		openLingQu(player)
		if ret then return ret;end
	end;
end;

------------------------------------------------------------------------------------------------------
function onPanelData(player, mdata)
	local data = util.decode(mdata)
	if not data then return end
	local cmd = data.cmd;
	if "onOpen" == data.cmd then
		pushBaseData(player,data.src)
	elseif "directDone" == data.cmd then
		taskDirectDone(player,data.src)
	elseif "taskChange" == data.cmd then
		taskChange(player)
	elseif "lingQu" == data.cmd then
		doLingQuAward(player,data.index,data.src)
	elseif "refreshStar" == data.cmd  then
		refreshStar(player,data.src)
	elseif "reqBuyTimes" == data.cmd then
		buyOtherChumo(player,data.src)
	elseif "finishChumo" == data.cmd then
		posnpc.fly(player,TASK_NPC)
	end
end
ckpanel.add_listener(ServerLua,onPanelData)

function pushBaseData(player,src)
	local data = {cmd="onOpen"}
	if util.ppn(player,const.PP_XYCM_TASKLV) == 0 then
		player:set_param(const.PP_XYCM_TASKLV,math.random(1,TASK_MAX_STAR))
	end 
	check_task_avariable(player)
	local index = util.ppn(player,const.PP_XYCM_TASKLV)
	data.taskState = player:get_task_state(task_id)
	data.taskNum = getTaskNum(player)
	data.buyNum = util.ppn(player,const.PP_RICHANG_BUYNUM)
	data.maxNum = TASK_MAX_NUM
	data.fastNeed = FastDoneNeed
	data.buyNeed = BuyTaskNeed
	data.freshNeed = FreshNeed
	data.npcName = TASK_NPC
	data.star = index
	data.award = getTaskAward(player)
	data.monNum = get_mon_num(player)
	data.mapName = get_mon_map(player)
	local s=player:get_task_state(task_id)
	local d=math.fmod(s,const.TASK_STATE_NUM)
	local n = util.ppn(player,const.PP_RICHANG_NUM)
	local m = util.ppn(player,const.PP_RICHANG_BUYNUM)
	local guide = nil
	if util.ppn(player,const.PP_XYCM_GUIDETIMES) < 2 then
		if d == const.TSACCE and index < 10 then
			guide = "chumo"
		end
	end
	if util.ppn(player,const.PP_XYCM_GUIDETIMES) <= 2 then
		if d == const.TSCOMP then
			guide = "chumolingqu"
		end
	end
	data.guide = guide
	if src then
		player:push_lua_table(src,util.encode(data))
	end
end 

function doLingQuAward(player,index,src,noSubVcoin)
	local lqdt = LingQuData[index]
	local taskState = player:get_task_state(task_id)
	local td = task_data[math.floor(taskState/10)]
	if lqdt and td then
		if not noSubVcoin then
			if lqdt.need and lqdt.need > 0 then
				if player:get_vcoin() < lqdt.need then
					player:alert(1,1,"金钻不足"..lqdt.need..",无法领取")
					util.alertChongZhi(player)
					return
				end
			end
		end
		local awd = util.clone(getTaskAward(player))
		if lqdt.mul > 1 then
			for k,v in ipairs(awd) do
				v.num = v.num*lqdt.mul
			end
		end
		if util.giveItems(player,consrc.CITEM_ADD_TASK_DUOBEI_LINGQU,awd,TASK_NAME.."-领取奖励",{title="清除障碍任务奖励",content="您背包格子不足，奖励已邮件发送，请及时整理背包。"},true) > 0 then
			if not noSubVcoin then
				if lqdt.need > 0 then
					player:sub_vcoin(lqdt.need,TASK_NAME.."-领取奖励")
				end
			end
			player:set_param(const.PP_RICHANG_NUM,util.ppn(player,const.PP_RICHANG_NUM)+1);
			if td.done_hook then td.done_hook(npc,player,td);ret=nil;end;
			player:set_param(const.PP_XYCM_TASKLV,0)
			local nid = gen_next_id(player);
			local rct = util.ppn(player,const.PP_RICHANG_NUM)
			if getTaskLeftNum(player) > 0 then
				player:set_task_state(task_id,task.util.ts(nid,const.TSACCE));
			else 
				player:set_task_state(task_id,task.util.ts(nid,const.TSUNAC));
			end
			player:push_task_data(task_id,0);
			player:set_param(const.PP_CHUMO_DUO_BEI,1);
			player:set_param(const.PP_CHUMO_FRESH_TIME,0)
			util.showEffect(player,"taskFinish")
			cktask.triger_task_change(player,task_id)
			cktask.triger_const_change(player,const.PP_RICHANG_NUM)
			if getTaskLeftNum(player) > 0 then
				posnpc.go(player,TASK_NPC)
			else
				-- player:alert(1,0,"您已完成今日所有物资收集任务！")
			end
		end
	end
end

function openTalk(player)
	local taskState = player:get_task_state(task_id)
	if taskState%10 == 4 then
		openLingQu(player)
	else
		util.openPanel(player,"Panel_chumo")
	end
end
function openLingQu(player)
	local taskState = player:get_task_state(task_id)
	local td = task_data[math.floor(taskState/10)]
	if td then
		util.openPanel(player,"Panel_npc_lingqu",{serverLua=ServerLua,cmd="lingQu",flag="task2000",npcName=TASK_NPC,award=getTaskAward(player),lqData=LingQuData,msg="    恭喜你完成了<font color='#00FF00'>【清扫障碍】</font>的任务，快来领取奖励吧！"})
	end
end
function taskChange(player)
	local taskState = player:get_task_state(task_id)
	local td = task_data[math.floor(taskState/10)]
	local tsd = task_state_data[taskState]
	if td and tsd then
		if taskState%10 == 2 or taskState%10 == 4 then
			if tsd.done then
				tsd.done(nil,player)
			end
		elseif taskState%10 == 3 then
			continueTask(player)
		else
			player:alert(1,0,"任务不可接")
		end
	end
end

function continueTask(player)
	local taskState = player:get_task_state(task_id)
	local td = task_data[math.floor(taskState/10)]
	local tsd = task_state_data[taskState]
	-- print("------continueTask------>>",taskState)
	if td and tsd then
		if taskState%10 == 3 then
			if td.pmap then
				if util.isInMap(player,td.pmap) then
					posmon.go(player,td.mon_map,td.need_target)
				else
					posmap.fly(player,td.pmap,true)
					posmon.go(player,td.mon_map,td.need_target)
				end
			elseif td.pnpc then
				if td.mapName and string.find(player:get_map():get_name(),td.mapName,nil,true) then
					posmon.go(player,td.mon_map,td.need_target)
				else
					if util.isInFuben(player) then
						posnpc.go(player,td.pnpc)
					else
						posnpc.fly(player,td.pnpc)
					end
				end
			end
		elseif taskState%10 == 4 then
			util.prompt(player,{msg="您已完成当前<font color='#00FF00'>".."物资收集任务</font>，是否前往提交任务？",okTitle="立即前往",actionData={src="player.onPanelData",data={cmd="posnpc",fly=TASK_NPC}}})
		end
	end
end

function getTaskAward(player)
	local index = util.ppn(player,const.PP_XYCM_TASKLV)
	local award = AwardData[index] or AwardData[0]
	return award
end

function gen_next_id(player)
	local lv = player:get_level()
	local tabs = 1
	local mylv = player:get_level()
	local zslv = util.ppn(player,const.PP_ZHSH_LEVEL)
	for i=1,#task_data do
		local td = task_data[i]
		if td.need_level and td.max_level then
			if mylv >= td.need_level and mylv <= td.max_level then
				tabs = i
				break
			end
		end
	end
	return tabs
end

function direct_fly_map(npc,player)
	local s=player:get_task_state(task_id);
	local b=math.floor(s / const.TASK_STATE_NUM);
	local d=math.fmod(s,const.TASK_STATE_NUM);
	local k=task_state_data[s];
	local n=task_data[b];
	if d == const.TSACED then
		if n then
			posmap.fly(player,n.need_map);
		end
	end
end
function taskDirectDone(player,src)
	local s=player:get_task_state(task_id);
	local b=math.floor(s / const.TASK_STATE_NUM);
	local d=math.fmod(s,const.TASK_STATE_NUM);
	local k=task_state_data[s];
	local n=task_data[b];
	if k and n then
		if util.ppn(player,const.PP_RICHANG_NUM) < const.RICHANG_MAX_NUM + util.ppn(player,const.PP_RICHANG_BUYNUM) then
			if d == const.TSACED or d == const.TSACCE then
				if 1 == player:sub_vcoin(FastDoneNeed, "task2000直接完成") then
					player:set_param(const.PP_XYCM_TASKLV,10);
					player:set_param(const.PP_CHUMO_DUO_BEI,3);
					player:set_task_state(task_id,task.util.ts(b,const.TSCOMP));
					player:push_task_data(task_id,0);
					doLingQuAward(player,3,src,true)
					pushBaseData(player,src)
					-- newgui.PanelRichang.addRiChangNum(player,"xycm")
					-- newgui.PanelTimedTask.checkTimedTask(player,"chumo")
				else
					util.closePanel(player,"Panel_chumo")
					util.alertChongZhi(player)
					player:alert(1,1,"金钻不足"..FastDoneNeed.."，无法直接完成")
					return 100;
				end
			else
				player:alert(1,1,"请先接受任务");
				return 100;
			end
		else 
			player:set_task_state(task_id,task.util.ts(b,const.TSUNAC));
			player:push_task_data(task_id,0);
			player:alert(1,1,"今日【障碍清扫】任务都已完成，可尝试购买一次任务")
			return 100
		end
	end
end

function get_mon_num( player )
	local s=player:get_task_state(const.TASK_ID_RICHANG);
	local b=math.floor(s / const.TASK_STATE_NUM);
	local n=task_data[b];
	if n then
		--return util.filterNumberOfString(n.need_target).."*"..n.need_num
		return "任意怪物*"..n.need_num
	end
end

function get_mon_map(player)
	local s=player:get_task_state(const.TASK_ID_RICHANG);
	local b=math.floor(s / const.TASK_STATE_NUM);
	local n=task_data[b];
	if n then
		--return posmon.getMap(player,n.need_target);
		return posmap.getmap(player,n.need_map)
	end
end

function check_task_avariable(player)
	local s=player:get_task_state(const.TASK_ID_RICHANG);
	local b=math.floor(s / const.TASK_STATE_NUM);
	local n=task_data[b];
	if not n then
		local nid = gen_next_id(player);
		if util.ppn(player,const.PP_RICHANG_NUM) < const.RICHANG_MAX_NUM + util.ppn(player,const.PP_RICHANG_BUYNUM) then
			player:set_task_state(task_id,task.util.ts(nid,const.TSACCE));
		else 
			player:set_task_state(task_id,task.util.ts(b,const.TSUNAC));
		end 
		player:push_task_data(task_id,0);
	end
end
function getTaskNum(player)
	return util.ppn(player,const.PP_RICHANG_NUM)
end
function getTaskLeftNum(player)
	if player:get_task_state(task_id) ~= 0 then
		return TASK_MAX_NUM + util.ppn(player,const.PP_RICHANG_BUYNUM) - getTaskNum(player)
	end
	return 0
end
-----刷新星级
function refreshStar(player,src)
	local d = math.fmod(player:get_task_state(const.TASK_ID_RICHANG),const.TASK_STATE_NUM)
	if d ~= const.TSACCE then return end
	if util.ppn(player,const.PP_XYCM_TASKLV) < 10 then
		if player:get_gamemoney() >= FreshNeed then
			player:sub_gamemoney(FreshNeed)
			local rd = math.random(1,10000)
			for k,v in ipairs(FreshPro) do
				if rd <= v.pro then
					player:set_param(const.PP_XYCM_TASKLV,v.star)
					player:set_param(const.PP_CHUMO_FRESH_TIME,util.ppn(player,const.PP_CHUMO_FRESH_TIME)+1)
					break
				end
			end
			player:alert(1,1,"刷新成功.");
		else
			player:alert(1,1,"您的元宝不足"..FreshNeed..",无法刷新!");
			gui.ItemSource.alert(player,"jinbi","元宝","元宝")
			return
		end
	else
		player:alert(1,1,"当前任务已满级，无法再次刷新！");
		return
	end
	if util.ppn(player,const.PP_XYCM_GUIDETIMES) < 10 then
		player:set_param(const.PP_XYCM_GUIDETIMES,util.ppn(player,const.PP_XYCM_GUIDETIMES)+1)
	end
	pushBaseData(player,src)
end 

function buyOtherChumo(player,src)
	local buyTime = util.ppn(player,const.PP_RICHANG_BUYNUM)
	if buyTime < const.RICHANG_MAX_NUM then
		local s=player:get_task_state(task_id)
		local d=math.fmod(s,const.TASK_STATE_NUM)
		local n = util.ppn(player,const.PP_RICHANG_NUM)
		local left = const.RICHANG_MAX_NUM + buyTime - n
		if 1 == player:sub_vcoin(BuyTaskNeed) then
			player:set_param(const.PP_RICHANG_BUYNUM,buyTime+1)
			local d = math.fmod(player:get_task_state(const.TASK_ID_RICHANG),const.TASK_STATE_NUM)
			if d == const.TSUNAC then
				local tid = gen_next_id(player)
				player:set_task_state(const.TASK_ID_RICHANG,task.util.ts(tid,const.TSACCE));
				player:push_task_data(const.TASK_ID_RICHANG,0);
			end
			player:push_lua_table("Panel_chumo",util.encode({cmd = "resBuyTimes",result = {task_state = d,left_times=left,buyflag=n}}))
			player:alert(1,1,"成功购买一次清扫障碍任务")
			pushBaseData(player,src)
		else
			player:alert(1,1,"您的金钻不足"..BuyTaskNeed..",无法购买额外次数!");
		end
	else 
		player:alert(1,1,"每天最多可购买10次额外的清扫障碍任务")
	end 
end
function check_richang_day(player)
	if util.ppn(player,const.PP_XYCM_TASKLV) == 0 then
		player:set_param(const.PP_XYCM_TASKLV,8)
	end
	player:set_param(const.PP_CHUMO_DUO_BEI,1);
	if util.ppn(player,const.PP_RICHANG_DAY) ~= today() then
		player:set_param(const.PP_RICHANG_DAY,today());
		player:set_param(const.PP_RICHANG_NUM,0);
		player:set_param(const.PP_RICHANG_BUYNUM,0)
		player:set_param(const.PP_CHUMO_FRESH_TIME,0)
		local ts = player:get_task_state(task_id)
		if ts % 10 == 1 then
			local nid = gen_next_id(player);
			player:set_task_state(task_id,task.util.ts(nid,const.TSACCE));
		else 
			player:set_task_state(task_id,player:get_task_state(task_id));
		end 
		player:push_task_data(task_id,0);
		player:refresh_npc_show_flags_inview();
	end
end
function check_level(player,lv,index)
	check_richang_day(player);
	local fst = player:get_task_state(task_id)
	if fst == 0 then
		if lv >= NeedLv then
			local nid = gen_next_id(player);
			if util.ppn(player,const.PP_RICHANG_NUM) < const.RICHANG_MAX_NUM + util.ppn(player,const.PP_RICHANG_BUYNUM) then
				player:set_task_state(task_id,task.util.ts(nid,const.TSACCE));
			else 
				player:set_task_state(task_id,task.util.ts(td.tid,const.TSUNAC));
			end 
			player:push_task_data(task_id,0);
		end
	else 
		if lv >= NeedLv and fst % 10 == 2 then
			local nid = gen_next_id(player);
			player:set_task_state(task_id,task.util.ts(nid,const.TSACCE));
			player:push_task_data(task_id,0);
		end 
	end
	task.util.check_level(player,lv,task_id,task_state_data,task_data);
end
cklevel.add_listener(check_level);