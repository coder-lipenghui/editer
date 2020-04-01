module(..., package.seeall)

local PanelNames = {
	["羽毛"] = {pName="Panel_wing"},
	["护体精元"] = {pName="Panel_huti"},
	["初级战神升阶丹"] = {pName="Panel_hero"},
	["中级战神升阶丹"] = {pName="Panel_hero"},
	["高级战神升阶丹"] = {pName="Panel_hero"},
	["宝藏钥匙"] = {pName="Panel_lottery"},
	["初级转生证明"] = {pName="Panel_role",params={tab=5}},
	["中级转生证明"] = {pName="Panel_role",params={tab=5}},
	["高级转生证明"] = {pName="Panel_role",params={tab=5}},
	["超级转生证明"] = {pName="Panel_role",params={tab=5}},
	["究级转生证明"] = {pName="Panel_role",params={tab=5}},

}

function openPanel(player,item_name,item_id,num, pos)
	local panelName = nil
	local params = nil
	if not PanelNames[item_name] then
		if string.find(item_name,"级强化石") then
			panelName = "Panel_qianghua"
		elseif string.find(item_name,"的进阶石") then
			panelName = "Panel_qianghua"
			params = {tab = 2}
		end
	else
		panelName = PanelNames[item_name].pName
		params = PanelNames[item_name].params
	end
	if panelName then
		util.openPanel(player,panelName,params)
	end
	return 0
end

function zhanshen(player,item_name,item_id,num, pos)
	player:set_hero_lv(1)
	player:set_hero_state(1)
	-- gui.PanelHero.ShowHeroAttr(player)
end

-----------------------------------------护符碎片
function hfspmin(player,item_name,item_id,num, pos)
    if 0 == player:remove_item_by_type_pos(item_id, pos, num ,consrc.ITEM_REMOVE_XSSP) then
        player:set_param(const.PP_BLOOD_CUR_EXP,util.ppn(player,const.PP_BLOOD_CUR_EXP)+5*num)
        player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(5*num).."护符经验")
        newgui.RedNodeManager.checkRed(player,"Panel_blood")
    end
    return 0
end
function hfspmid(player,item_name,item_id,num, pos)
    if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_XSSP) then
        player:set_param(const.PP_BLOOD_CUR_EXP,util.ppn(player,const.PP_BLOOD_CUR_EXP)+50*num)
        player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(50*num).."护符经验")
        newgui.RedNodeManager.checkRed(player,"Panel_blood")
    end
    return 0
end
function hfspmax(player,item_name,item_id,num, pos)
    if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_XSSP) then
        player:set_param(const.PP_BLOOD_CUR_EXP,util.ppn(player,const.PP_BLOOD_CUR_EXP)+500*num)
        player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(500*num).."护符经验")
        newgui.RedNodeManager.checkRed(player,"Panel_blood")
    end
    return 0
end

----------------圣盾-------------------------
function hdspmin(player,item_name,item_id,num, pos)
	local MaxUse = 200
	if util.ppn(player,const.PP_SHENGDUN_MIN) + num > MaxUse then
		player:alert(1,1,item_name.." 每日限制使用"..MaxUse.."个!")
		globaldef.pushItemUseFull(player,item_id)
		return 0
	end
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_HDSP) then
		player:set_param(const.PP_SHENGDUN_MIN,util.ppn(player,const.PP_SHENGDUN_MIN) + num);
		player:set_param(const.PP_DUN_CUR_EXP,util.ppn(player,const.PP_DUN_CUR_EXP)+10*num)
		player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(10*num).."护盾经验")
		player:alert(1,1,"今日已使用 "..item_name.." "..util.ppn(player,const.PP_SHENGDUN_MIN).."/"..MaxUse.."个")
		newgui.RedNodeManager.checkRed(player,"Panel_dun")
	end
	if util.ppn(player,const.PP_SHENGDUN_MIN) >= MaxUse then
		globaldef.pushItemUseFull(player,item_id)
	end
	return 0
end
function hdspmid(player,item_name,item_id,num, pos)
	local MaxUse = 50
	if util.ppn(player,const.PP_SHENGDUN_MID) + num > MaxUse then
		player:alert(1,1,item_name.." 每日限制使用"..MaxUse.."个!")
		globaldef.pushItemUseFull(player,item_id)
		return 0
	end
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_HDSP) then
		player:set_param(const.PP_SHENGDUN_MID,util.ppn(player,const.PP_SHENGDUN_MID) + num);
		player:set_param(const.PP_DUN_CUR_EXP,util.ppn(player,const.PP_DUN_CUR_EXP)+100*num)
		player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(100*num).."护盾经验")
		player:alert(1,1,"今日已使用 "..item_name.." "..util.ppn(player,const.PP_SHENGDUN_MIN).."/"..MaxUse.."个")
		newgui.RedNodeManager.checkRed(player,"Panel_dun")
	end
	if util.ppn(player,const.PP_SHENGDUN_MID) >= MaxUse then
		globaldef.pushItemUseFull(player,item_id)
	end
	return 0
end
function hdspmax(player,item_name,item_id,num, pos)
	local MaxUse = 10
	if util.ppn(player,const.PP_SHENGDUN_MAX) + num > MaxUse then
		player:alert(1,1,item_name.." 每日限制使用"..MaxUse.."个!")
		globaldef.pushItemUseFull(player,item_id)
		return 0
	end
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_HDSP) then
		player:set_param(const.PP_SHENGDUN_MAX,util.ppn(player,const.PP_SHENGDUN_MAX) + num);
		player:set_param(const.PP_DUN_CUR_EXP,util.ppn(player,const.PP_DUN_CUR_EXP)+1000*num)
		player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(1000*num).."护盾经验")
		player:alert(1,1,"今日已使用 "..item_name.." "..util.ppn(player,const.PP_SHENGDUN_MIN).."/"..MaxUse.."个")
		newgui.RedNodeManager.checkRed(player,"Panel_dun")
	end
	if util.ppn(player,const.PP_SHENGDUN_MAX) >= MaxUse then
		globaldef.pushItemUseFull(player,item_id)
	end
	return 0
end
----------------战旗-------------------------
function zqspmin(player,item_name,item_id,num, pos)
	local MaxUse = 200
	if util.ppn(player,const.PP_ZHANQI_MIN) + num > MaxUse then
		player:alert(1,1,item_name.." 每日限制使用"..MaxUse.."个!")
		globaldef.pushItemUseFull(player,item_id)
		return 0
	end
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_USESUIPIAN) then
		player:set_param(const.PP_ZHANQI_MIN,util.ppn(player,const.PP_ZHANQI_MIN) + num);
		player:set_param(const.PP_ZHANQI_CUR_EXP,util.ppn(player,const.PP_ZHANQI_CUR_EXP)+10*num)
		player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(10*num).."战旗经验")
		player:alert(1,1,"今日已使用 "..item_name.." "..util.ppn(player,const.PP_ZHANQI_MIN).."/"..MaxUse.."个")
		newgui.RedNodeManager.checkRed(player,"Panel_zhanqi")
	end
	if util.ppn(player,const.PP_ZHANQI_MIN) >= MaxUse then
		globaldef.pushItemUseFull(player,item_id)
	end
	return 0
end
function zqspmid(player,item_name,item_id,num, pos)
	local MaxUse = 50
	if util.ppn(player,const.PP_ZHANQI_MID) + num > MaxUse then
		player:alert(1,1,item_name.." 每日限制使用"..MaxUse.."个!")
		globaldef.pushItemUseFull(player,item_id)
		return 0
	end
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_USESUIPIAN) then
		player:set_param(const.PP_ZHANQI_MID,util.ppn(player,const.PP_ZHANQI_MID) + num);
		player:set_param(const.PP_ZHANQI_CUR_EXP,util.ppn(player,const.PP_ZHANQI_CUR_EXP)+100*num)
		player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(100*num).."战旗经验")
		player:alert(1,1,"今日已使用 "..item_name.." "..util.ppn(player,const.PP_ZHANQI_MIN).."/"..MaxUse.."个")
		newgui.RedNodeManager.checkRed(player,"Panel_zhanqi")
	end
	if util.ppn(player,const.PP_ZHANQI_MID) >= MaxUse then
		globaldef.pushItemUseFull(player,item_id)
	end
	return 0
end
function zqspmax(player,item_name,item_id,num, pos)
	local MaxUse = 10
	if util.ppn(player,const.PP_ZHANQI_MAX) + num > MaxUse then
		player:alert(1,1,item_name.." 每日限制使用"..MaxUse.."个!")
		globaldef.pushItemUseFull(player,item_id)
		return 0
	end
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_USESUIPIAN) then
		player:set_param(const.PP_ZHANQI_MAX,util.ppn(player,const.PP_ZHANQI_MAX) + num);
		player:set_param(const.PP_ZHANQI_CUR_EXP,util.ppn(player,const.PP_ZHANQI_CUR_EXP)+1000*num)
		player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(1000*num).."战旗经验")
		player:alert(1,1,"今日已使用 "..item_name.." "..util.ppn(player,const.PP_ZHANQI_MIN).."/"..MaxUse.."个")
		newgui.RedNodeManager.checkRed(player,"Panel_zhanqi")
	end
	if util.ppn(player,const.PP_ZHANQI_MAX) >= MaxUse then
		globaldef.pushItemUseFull(player,item_id)
	end
	return 0
end
----------------灵珠-------------------------
function lzspmin(player,item_name,item_id,num, pos)
	local MaxUse = 200
	if util.ppn(player,const.PP_LINGZHU_MIN) + num > MaxUse then
		player:alert(1,1,item_name.." 每日限制使用"..MaxUse.."个!")
		globaldef.pushItemUseFull(player,item_id)
		return 0
	end
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_USESUIPIAN) then
		player:set_param(const.PP_LINGZHU_MIN,util.ppn(player,const.PP_LINGZHU_MIN) + num);
		player:set_param(const.PP_LINGZHU_CUR_EXP,util.ppn(player,const.PP_LINGZHU_CUR_EXP)+10*num)
		player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(10*num).."灵珠经验")
		player:alert(1,1,"今日已使用 "..item_name.." "..util.ppn(player,const.PP_LINGZHU_MIN).."/"..MaxUse.."个")
		newgui.RedNodeManager.checkRed(player,"Panel_lingzhu")
	end
	if util.ppn(player,const.PP_LINGZHU_MIN) >= MaxUse then
		globaldef.pushItemUseFull(player,item_id)
	end
	return 0
end
function lzspmid(player,item_name,item_id,num, pos)
	local MaxUse = 50
	if util.ppn(player,const.PP_LINGZHU_MID) + num > MaxUse then
		player:alert(1,1,item_name.." 每日限制使用"..MaxUse.."个!")
		globaldef.pushItemUseFull(player,item_id)
		return 0
	end
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_USESUIPIAN) then
		player:set_param(const.PP_LINGZHU_MID,util.ppn(player,const.PP_LINGZHU_MID) + num);
		player:set_param(const.PP_LINGZHU_CUR_EXP,util.ppn(player,const.PP_LINGZHU_CUR_EXP)+100*num)
		player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(100*num).."灵珠经验")
		player:alert(1,1,"今日已使用 "..item_name.." "..util.ppn(player,const.PP_LINGZHU_MIN).."/"..MaxUse.."个")
		newgui.RedNodeManager.checkRed(player,"Panel_lingzhu")
	end
	if util.ppn(player,const.PP_LINGZHU_MID) >= MaxUse then
		globaldef.pushItemUseFull(player,item_id)
	end
	return 0
end
function lzspmax(player,item_name,item_id,num, pos)
	local MaxUse = 10
	if util.ppn(player,const.PP_LINGZHU_MAX) + num > MaxUse then
		player:alert(1,1,item_name.." 每日限制使用"..MaxUse.."个!")
		globaldef.pushItemUseFull(player,item_id)
		return 0
	end
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_USESUIPIAN) then
		player:set_param(const.PP_LINGZHU_MAX,util.ppn(player,const.PP_LINGZHU_MAX) + num);
		player:set_param(const.PP_LINGZHU_CUR_EXP,util.ppn(player,const.PP_LINGZHU_CUR_EXP)+1000*num)
		player:alert(1,1,"成功使用"..num.."个 "..item_name..",增加"..(1000*num).."灵珠经验")
		player:alert(1,1,"今日已使用 "..item_name.." "..util.ppn(player,const.PP_LINGZHU_MIN).."/"..MaxUse.."个")
		newgui.RedNodeManager.checkRed(player,"Panel_lingzhu")
	end
	if util.ppn(player,const.PP_LINGZHU_MAX) >= MaxUse then
		globaldef.pushItemUseFull(player,item_id)
	end
	return 0
end
------------------------经验丹--------------------------
function expdan1(player,item_name,item_id,num, pos)
    if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_EXP1) then
        player:add_exp(100000*num)
        player:alert(1,1,"成功使用 "..item_name..",增加"..10*num.."万经验")
    end
    return 0
end
function expdan2(player,item_name,item_id,num, pos)
    if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_EXP2) then
        player:add_exp(1000000*num)
        player:alert(1,1,"成功使用 "..item_name..",增加"..100*num.."万经验")
    end
    return 0
end
function expdan3(player,item_name,item_id,num, pos)
    if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_EXP3) then
		player:add_exp(10000000*num)
        player:alert(1,1,"成功使用 "..item_name..",增加"..1000*num.."万经验")
    end
    return 0
end
function expdan4(player,item_name,item_id,num, pos)
    if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_EXP3) then
		player:add_exp(50000000*num)
        player:alert(1,1,"成功使用 "..item_name..",增加"..5000*num.."万经验")
    end
    return 0
end
function expdan5(player,item_name,item_id,num, pos)
	if player:get_level() >= 78 then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_EXP5) then
			player:add_exp(100000000*num)
			player:alert(1,1,"成功使用 "..item_name..",增加"..num.."亿经验")
		end
	else 
		player:alert(1,1,"78级以上才可使用")
		return 0
	end
    return 0
end
function expdan6(player,item_name,item_id,num, pos)
	if player:get_level() >= 78 then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_EXP6) then
			player:add_exp(100000000*num)
			player:alert(1,1,"成功使用 "..item_name..",增加"..num.."亿经验")
		end
	else 
		player:alert(1,1,"78级以上才可使用")
		return 0
	end
    return 0
end

function expLvdan1(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, 1,consrc.ITEM_REMOVE_EXPLV1) then
		if player:get_level() < 70 then
			player:set_level(player:get_level()+1);
			player:alert(1,1,"成功使用 "..item_name..",直升一级!")
		else
			player:add_exp(2000000)
			player:alert(1,1,"成功使用 "..item_name..",增加200万经验")
		end
	end
	return 0
end
function expLvdan2(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, 1,consrc.ITEM_REMOVE_EXPLV1) then
		if player:get_level() < 85 then
			player:set_level(player:get_level()+1);
			player:alert(1,1,"成功使用 "..item_name..",直升一级!")
		else
			player:add_exp(200000000)
			player:alert(1,1,"成功使用 "..item_name..",增加2亿经验")
		end
	end
	return 0
end
------------------------降魔币--------------------------
function bvcoin1(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_EXP2) then
		player:add_vcoin_bind(10*num)
		player:alert(1,1,"降魔币+"..10*num)
	end
	return 0
end
function bvcoin2(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_EXP2) then
		player:add_vcoin_bind(100*num)
		player:alert(1,1,"降魔币+"..100*num)
	end
	return 0
end
function bvcoin3(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_EXP2) then
		player:add_vcoin_bind(500*num)
		player:alert(1,1,"降魔币+"..500*num)
	end
	return 0
end
---------------------转生经验丹------------------------

function zhuansexp(player,item_name,item_id,num, pos)
	local zsdan = newgui.PanelReborn.getZsDan()
	local zsd = zsdan and zsdan[item_name]
	if zsd then
		local canUseNum = newgui.PanelReborn.getCanUseNumZsDan(player,item_name)
		local limitnum,limitmax = newgui.PanelVip.getZSDanNum(player)
		if canUseNum <= 0 then
			player:alert(1,1,"使用次数已用完,每日限制使用"..limitnum.."个!")
			if limitnum < limitmax then
				player:alert(1,1,"提升vip等级可提高使用上限!")
			end
			globaldef.pushItemUseFull(player,item_id)
			return 0
		end
		if num > canUseNum then
			num = canUseNum
		end
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_GONGXUN) then
			player:set_param(const.PP_ZHUANSHENG_MAX,util.ppn(player,const.PP_ZHUANSHENG_MAX) + num);
			newgui.PanelReborn.changeZsExp(player,zsd.zexp*num)
			player:alert(1,1,"增加"..(zsd.zexp*num).."转生经验")
			player:alert(1,1,"今日已使用"..util.ppn(player,const.PP_ZHUANSHENG_MAX).."/"..limitnum.."个")
		end
		canUseNum = limitnum - util.ppn(player,const.PP_ZHUANSHENG_MAX)
		if canUseNum <= 0 then
			globaldef.pushItemUseFull(player,item_id)
		end
	end
	
	return 0
end

---------------------功勋卷------------------------
local gxj={
	["小型功勋卷"]={limit=0,pconst=0,zexp=1000},
	["中型功勋卷"]={limit=0,pconst=0,zexp=5000},
	["大型功勋卷"]={limit=0,pconst=0,zexp=20000},
}

function gongxun(player,item_name,item_id,num, pos)
	local zsd = gxj[item_name]
	if zsd then
		--if zsd.limit > 0 and if util.ppn(player,zsd.pconst) + num > zsd.limit then
		--	player:alert(1,1,"每日限制使用"..zsd.limit.."个!")
		--	return 0
		--end
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_GONGXUN) then
			player:add_honor(zsd.zexp*num)
			player:alert(1,1,"增加"..(zsd.zexp*num).."功勋值")
		end
	end
	
	return 0
end


---------------------装备精魂------------------------
local jingpo={
	["初级装备精魂"]={limit=0,pconst=0,zexp=10},
	["中级装备精魂"]={limit=0,pconst=0,zexp=50},
	["高级装备精魂"]={limit=0,pconst=0,zexp=500},
}

function zbjp(player,item_name,item_id,num, pos)
	local zsd = jingpo[item_name]
	if zsd then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_JINGPO) then
			count.m_countTimes("jifen","jifen_"..(player:get_name()),zsd.zexp*num)
			player:set_param(const.PP_EQUIP_JIFEN,util.ppn(player,const.PP_EQUIP_JIFEN)+(zsd.zexp*num))
			player:alert(1,1,"增加"..(zsd.zexp*num).."装备积分")
		end
	end
	
	return 0
end

---------------------金条金砖------------------------
local zsdan={
	["金条(小)"]={limit=0,pconst=0,money=100000},
	["金条(中)"]={limit=0,pconst=0,money=500000},
	["金条(大)"]={limit=0,pconst=0,money=800000},
	["金砖(小)"]={limit=0,pconst=0,money=1000000},
	["金砖(中)"]={limit=0,pconst=0,money=3000000},
	["金砖(大)"]={limit=0,pconst=0,money=5000000},
}

function jinzhuan(player,item_name,item_id,num, pos)
	local zsd = zsdan[item_name]
	if zsd then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_GONGXUN) then
			player:add_gamemoney(zsd.money*num)
			player:alert(1,1,"增加"..(zsd.money*num).."元宝")
			newgui.RedNodeManager.checkRed(player,"Panel_qianghua",1)
		end
	end	
	return 0
end

local boss_zhao={
	[10081]={
		{boss="虫后91",prob=40},
		{boss="沃谷教主91",prob=30},
		{boss="白猪妖91",prob=20},
		{boss="驽玛教主91",prob=10},
	},
	[10082]={
		{boss="晓月恶魔91",prob=50},
		{boss="魔龙教主91",prob=40},
		{boss="火龙神91",prob=30},
	},
	[10083]={
		{boss="雪域魔王91",prob=70},
		{boss="九尾狐妖91",prob=30},
	},
}

function bossling(player,item_name,item_id,num, pos)
	if player:get_map():get_id() == "v003" then
		local bdata = boss_zhao[item_id]
		if bdata then
			local rd = math.random(1,100)
			local add = 0
			for i =1,#bdata do
				add = add + bdata[i].prob
				if rd <= add then
					local x,y = player:get_pos()
					local cx,cy = player:get_map():gen_rand_pos(x,y,5)
					if cx >0 then
						player:get_map():mon_gen(cx,cy,bdata[i].boss,1,1,1,1,"no_owner");
						local target = util.trimNumber(bdata[i].boss)
						server.info(10010,1,"玩家<font color='#FF8A01'>"..player:get_name().."</font>召唤的[<font color='#ff0000'>"..target.."</font>]出现在了土城!")
						return 1
					end
				end
			end
		end
		return 0
	else
		player:alert(1, 1, "BOSS召唤令只能在荒漠土城使用!") return 0
	end
end

---------------------------------------------------首饰宝箱
local jewelry = {
	[10084] = {
		[1] = {{itemname="雷霆头盔",itemid=40011},{itemname="烈焰头盔",itemid=40012},{itemname="光芒头盔",itemid=40013}},
		[2] = {{itemname="雷霆项链",itemid=70011},{itemname="烈焰项链",itemid=70012},{itemname="光芒项链",itemid=70013}},
		[3] = {{itemname="雷霆手镯",itemid=60011},{itemname="烈焰手镯",itemid=60012},{itemname="光芒手镯",itemid=60013}},
		[4] = {{itemname="雷霆戒指",itemid=50011},{itemname="烈焰戒指",itemid=50012},{itemname="光芒戒指",itemid=50013}},
		[5] = {{itemname="雷霆腰带",itemid=90011},{itemname="烈焰腰带",itemid=90012},{itemname="光芒腰带",itemid=90013}},
		[6] = {{itemname="雷霆靴子",itemid=100011},{itemname="烈焰靴子",itemid=100012},{itemname="光芒靴子",itemid=100013}},
	},
	[10085] = {
		[1] = {{itemname="龙天战盔",itemid=40014},{itemname="龙天魔盔",itemid=40015},{itemname="龙天道盔",itemid=40016}},
		[2] = {{itemname="龙天战链",itemid=70014},{itemname="龙天魔链",itemid=70015},{itemname="龙天道链",itemid=70016}},
		[3] = {{itemname="龙天战镯",itemid=60014},{itemname="龙天魔镯",itemid=60015},{itemname="龙天道镯",itemid=60016}},
		[4] = {{itemname="龙天战戒",itemid=50014},{itemname="龙天魔戒",itemid=50015},{itemname="龙天道戒",itemid=50016}},
		[5] = {{itemname="龙天战带",itemid=90014},{itemname="龙天魔带",itemid=90015},{itemname="龙天道带",itemid=90016}},
		[6] = {{itemname="龙天战靴",itemid=100014},{itemname="龙天魔靴",itemid=100015},{itemname="龙天道靴",itemid=100016}},
	},
	[10086] = {
		[1] = {{itemname="王者战盔",itemid=40017},{itemname="王者魔盔",itemid=40018},{itemname="王者道盔",itemid=40019}},
		[2] = {{itemname="王者战链",itemid=70017},{itemname="王者魔链",itemid=70018},{itemname="王者道链",itemid=70019}},
		[3] = {{itemname="王者战镯",itemid=60017},{itemname="王者魔镯",itemid=60018},{itemname="王者道镯",itemid=60019}},
		[4] = {{itemname="王者战戒",itemid=50017},{itemname="王者魔戒",itemid=50018},{itemname="王者道戒",itemid=50019}},
		[5] = {{itemname="王者战带",itemid=90017},{itemname="王者魔带",itemid=90018},{itemname="王者道带",itemid=90019}},
		[6] = {{itemname="王者战靴",itemid=100017},{itemname="王者魔靴",itemid=100018},{itemname="王者道靴",itemid=100019}},
	},
	[10087] = {
		[1] = {{itemname="金牛战盔",itemid=40020},{itemname="金牛魔盔",itemid=40021},{itemname="金牛道盔",itemid=40022}},
		[2] = {{itemname="金牛战链",itemid=70020},{itemname="金牛魔链",itemid=70021},{itemname="金牛道链",itemid=70022}},
		[3] = {{itemname="金牛战镯",itemid=60020},{itemname="金牛魔镯",itemid=60021},{itemname="金牛道镯",itemid=60022}},
		[4] = {{itemname="金牛战戒",itemid=50020},{itemname="金牛魔戒",itemid=50021},{itemname="金牛道戒",itemid=50022}},
		[5] = {{itemname="金牛战带",itemid=90020},{itemname="金牛魔带",itemid=90021},{itemname="金牛道带",itemid=90022}},
		[6] = {{itemname="金牛战靴",itemid=100020},{itemname="金牛魔靴",itemid=100021},{itemname="金牛道靴",itemid=100022}},
	},
	[10088] = {
		[1] = {{itemname="天龙战盔",itemid=40023},{itemname="天龙魔盔",itemid=40024},{itemname="天龙道盔",itemid=40025}},
		[2] = {{itemname="天龙战链",itemid=70023},{itemname="天龙魔链",itemid=70024},{itemname="天龙道链",itemid=70025}},
		[3] = {{itemname="天龙战镯",itemid=60023},{itemname="天龙魔镯",itemid=60024},{itemname="天龙道镯",itemid=60025}},
		[4] = {{itemname="天龙战戒",itemid=50023},{itemname="天龙魔戒",itemid=50024},{itemname="天龙道戒",itemid=50025}},
		[5] = {{itemname="天龙战带",itemid=90023},{itemname="天龙魔带",itemid=90024},{itemname="天龙道带",itemid=90025}},
		[6] = {{itemname="天龙战靴",itemid=100023},{itemname="天龙魔靴",itemid=100024},{itemname="天龙道靴",itemid=100025}},
	},
	[10090] = {
		[1] = {{itemname="玉兔战盔",itemid=40026},{itemname="玉兔魔盔",itemid=40027},{itemname="玉兔道盔",itemid=40028}},
		[2] = {{itemname="玉兔战链",itemid=70026},{itemname="玉兔魔链",itemid=70027},{itemname="玉兔道链",itemid=70028}},
		[3] = {{itemname="玉兔战镯",itemid=60026},{itemname="玉兔魔镯",itemid=60027},{itemname="玉兔道镯",itemid=60028}},
		[4] = {{itemname="玉兔战戒",itemid=50026},{itemname="玉兔魔戒",itemid=50027},{itemname="玉兔道戒",itemid=50028}},
		[5] = {{itemname="玉兔战带",itemid=90026},{itemname="玉兔魔带",itemid=90027},{itemname="玉兔道带",itemid=90028}},
		[6] = {{itemname="玉兔战靴",itemid=100026},{itemname="玉兔魔靴",itemid=100027},{itemname="玉兔道靴",itemid=100028}},
	},
	[10092] = {
		[1] = {{itemname="青龙战盔",itemid=40029},{itemname="青龙魔盔",itemid=40030},{itemname="青龙道盔",itemid=40031}},
		[2] = {{itemname="青龙战链",itemid=70029},{itemname="青龙魔链",itemid=70030},{itemname="青龙道链",itemid=70031}},
		[3] = {{itemname="青龙战镯",itemid=60029},{itemname="青龙魔镯",itemid=60030},{itemname="青龙道镯",itemid=60031}},
		[4] = {{itemname="青龙战戒",itemid=50029},{itemname="青龙魔戒",itemid=50030},{itemname="青龙道戒",itemid=50031}},
		[5] = {{itemname="青龙战带",itemid=90029},{itemname="青龙魔带",itemid=90030},{itemname="青龙道带",itemid=90031}},
		[6] = {{itemname="青龙战靴",itemid=100029},{itemname="青龙魔靴",itemid=100030},{itemname="青龙道靴",itemid=100031}},
	},
	[10094] = {
		[1] = {{itemname="真皇战盔",itemid=40032},{itemname="真皇魔盔",itemid=40033},{itemname="真皇道盔",itemid=40034}},
		[2] = {{itemname="真皇战链",itemid=70032},{itemname="真皇魔链",itemid=70033},{itemname="真皇道链",itemid=70034}},
		[3] = {{itemname="真皇战镯",itemid=60032},{itemname="真皇魔镯",itemid=60033},{itemname="真皇道镯",itemid=60034}},
		[4] = {{itemname="真皇战戒",itemid=50032},{itemname="真皇魔戒",itemid=50033},{itemname="真皇道戒",itemid=50034}},
		[5] = {{itemname="真皇战带",itemid=90032},{itemname="真皇魔带",itemid=90033},{itemname="真皇道带",itemid=90034}},
		[6] = {{itemname="真皇战靴",itemid=100032},{itemname="真皇魔靴",itemid=100033},{itemname="真皇道靴",itemid=100034}},
	},
	[10096] = {
		[1] = {{itemname="御龙战盔",itemid=40035},{itemname="御龙魔盔",itemid=40036},{itemname="御龙道盔",itemid=40037}},
		[2] = {{itemname="御龙战链",itemid=70035},{itemname="御龙魔链",itemid=70036},{itemname="御龙道链",itemid=70037}},
		[3] = {{itemname="御龙战镯",itemid=60035},{itemname="御龙魔镯",itemid=60036},{itemname="御龙道镯",itemid=60037}},
		[4] = {{itemname="御龙战戒",itemid=50035},{itemname="御龙魔戒",itemid=50036},{itemname="御龙道戒",itemid=50037}},
		[5] = {{itemname="御龙战带",itemid=90035},{itemname="御龙魔带",itemid=90036},{itemname="御龙道带",itemid=90037}},
		[6] = {{itemname="御龙战靴",itemid=100035},{itemname="御龙魔靴",itemid=100036},{itemname="御龙道靴",itemid=100037}},
	},
	[10098] = {
		[1] = {{itemname="至尊战盔",itemid=40038},{itemname="至尊魔盔",itemid=40039},{itemname="至尊道盔",itemid=40040}},
		[2] = {{itemname="至尊战链",itemid=70038},{itemname="至尊魔链",itemid=70039},{itemname="至尊道链",itemid=70040}},
		[3] = {{itemname="至尊战镯",itemid=60038},{itemname="至尊魔镯",itemid=60039},{itemname="至尊道镯",itemid=60040}},
		[4] = {{itemname="至尊战戒",itemid=50038},{itemname="至尊魔戒",itemid=50039},{itemname="至尊道戒",itemid=50040}},
		[5] = {{itemname="至尊战带",itemid=90038},{itemname="至尊魔带",itemid=90039},{itemname="至尊道带",itemid=90040}},
		[6] = {{itemname="至尊战靴",itemid=100038},{itemname="至尊魔靴",itemid=100039},{itemname="至尊道靴",itemid=100040}},
	},
}

function boxshoushi(player,item_name,item_id,num, pos)
	if not jewelry[item_id] then return 0 end
	local data = jewelry[item_id]
	local info = data[math.random(#data)]
	local job = player:get_job_id()
	local itemdata = info[job-99]
	if itemdata then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_SHOUSHI_BOX) then
			player:c_item(consrc.CITEM_ADD_SHOUSHI_BOX,itemdata.itemid,1,0,"首饰宝箱");
			player:alert(1,1,"成功打开首饰宝箱获得"..itemdata.itemname)
		end
	end
	return 0
end


local hydata={
	["活跃礼包(初级)"]={limit=0,pconst=0,value=20},
	["活跃礼包(中级)"]={limit=0,pconst=0,value=100},
	["活跃礼包(高级)"]={limit=0,pconst=0,value=300},
}

function huoyue(player,item_name,item_id,num, pos)
	local hy = hydata[item_name]
	if hy then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_GONGXUN) then
			local addhy = hy.value*num
			player:set_param(const.PP_HUOYUE_TODAY,util.ppn(player,const.PP_HUOYUE_TODAY)+addhy)
			player:set_param(const.PP_HUOYUE_ALL,util.ppn(player,const.PP_HUOYUE_ALL)+addhy)
			player:set_param(const.PP_DIANXING_JIFEN,util.ppn(player,const.PP_DIANXING_JIFEN)+addhy)
			newgui.PanelRichang.addSevenDayHuoYue(player,addhy)
			player:alert(1,1,"增加活跃值"..addhy)
		end
	end	
	return 0
end

-----

local htdata={
	["护体神丹(初级)"]={limit=0,pconst=0,value=10},
	["护体神丹(中级)"]={limit=0,pconst=0,value=50},
	["护体神丹(高级)"]={limit=0,pconst=0,value=250},
}

function hutishdan(player,item_name,item_id,num,pos)
	local hy = htdata[item_name]
	if hy then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_GONGXUN) then
			player:c_item(consrc.CITEM_ADD_HUTISHENDAN,"护体精元",hy.value*num,1,"护体神丹");
		end
	end	
	return 0
end


function tequantiyan(player,item_name,item_id,num,pos)
	if util.ppn(player,const.PP_ZHIZUN_FREE) ~= 2 then
		player:set_status(29,1800,1,1,11);
		player:alert(11,1,"成功使用 黄金特权体验卡,获得2小时体验时间！")
		player:set_param(const.PP_ZHIZUN_FREE,2)
		util.openPanel(player,"Panel_zhizun")
		newgui.RedNodeManager.checkRed(player,"Panel_boss")
	else
		player:alert(1,1,"您已经使用过 黄金特权体验卡 了!")
		return 0
	end
end

------------------------------------------充值金钻
local testyb={
	["测试金钻100"]={value=100},
	["测试金钻1000"]={value=1000},
	["测试金钻10000"]={value=10000},
}

function csyblb(player,item_name,item_id,num, pos)
	local hy = testyb[item_name]
	if hy then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_TESTVCOIN) then
			player:add_vcoin_best_enable(hy.value*num,consrc.VCOIN_ADD_BY_TEST_LB)
			newgui.PanelKaiqu.catchChongzhi(player,hy.value*num)
			player:alert(1,1,"获得测试金钻"..hy.value*num)
		end
	end	
	return 0
end

----------------------------------------------------------------------宝石宝箱
local gem_box = {
	[12101] = {"一级攻击宝石","一级物防宝石","一级魔防宝石","一级生命宝石"},
	[12102] = {"二级攻击宝石","二级物防宝石","二级魔防宝石","二级生命宝石"},
	[12103] = {"三级攻击宝石","三级物防宝石","三级魔防宝石","三级生命宝石"},
	[12104] = {"四级攻击宝石","四级物防宝石","四级魔防宝石","四级生命宝石"},
	[12105] = {"五级攻击宝石","五级物防宝石","五级魔防宝石","五级生命宝石"},
	[12106] = {"六级攻击宝石","六级物防宝石","六级魔防宝石","六级生命宝石"},
	[12107] = {"七级攻击宝石","七级物防宝石","七级魔防宝石","七级生命宝石"},
	[12108] = {"八级攻击宝石","八级物防宝石","八级魔防宝石","八级生命宝石"},
	[12109] = {"九级攻击宝石","九级物防宝石","九级魔防宝石","九级生命宝石"},
	[12110] = {"十级攻击宝石","十级物防宝石","十级魔防宝石","十级生命宝石"},
	[12111] = {"十一级攻击宝石","十一级物防宝石","十一级魔防宝石","十一级生命宝石"},
	[12112] = {"十二级攻击宝石","十二级物防宝石","十二级魔防宝石","十二级生命宝石"},
}
function gembx(player,item_name,item_id,num, pos)
	local gb = gem_box[item_id]
	if gb then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_GEM_BOX) then
			math.random(#gb)
			math.random(#gb)
			math.random(#gb)
			if num > 1 then
				local tmp = {}
				for i=1,num do
					table.insert(tmp,math.random(#gb))
				end
				for k,v in ipairs(tmp) do
					player:c_item(consrc.CITEM_ADD_GEM_BOX,gb[v],1,1,"宝石宝箱")
				end 
				player:alert(1,1,"成功打开宝石宝箱，获得"..num.."个"..(item_id%100).."级宝石，点击镶嵌查看")
			else 
				local bs = math.random(#gb)
				player:c_item(consrc.CITEM_ADD_GEM_BOX,gb[bs],1,1,"宝石宝箱")
				player:alert(1,1,"成功打开宝石宝箱，获得"..gb[bs])
			end 
		end
	end 
	return 0
end 
------------------------------------------掉落金钻
local dlyb={
	["10金钻"]={value=10},
	["20金钻"]={value=20},
	["50金钻"]={value=50},
	["100金钻"]={value=100},
}

function ybcoin(player,item_name,item_id,num, pos)
	local hy = dlyb[item_name]
	if hy then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_TESTVCOIN) then
			player:add_vcoin_best_enable(hy.value*num,consrc.VCOIN_ADD_BY_PICK)
			player:alert(1,1,"获得金钻"..hy.value*num)
		end
	end	
	return 0
end


function guildcall(player,item_name,item_id,num, pos)
	local guild_name = player:get_guild()
	if guild_name == "" then
		player:alert(1,1,"当前尚未拥有公会,不能使用!")
		return 0
	end
	local actionData = {src="item.chufa.GuildCallTriger",data={cmd="gcall",}}
	util.prompt(player,{msg="是否使用 公会召集令,召唤成员前来协助?",okTitle="使  用",actionData=actionData})
	return 0;
end

function GuildCallTriger(player,mdata)
	--print("...",mdata)
	local data = util.decode(mdata);
	if data and data.cmd then
		if data.cmd == "gcall"  then
			confirmUse(player,data)
		end
		if data.cmd == "memcall"  then
			confirmMemEnter(player,data)
		end
	end
end
ckpanel.add_listener("item.chufa.GuildCallTriger",item.chufa.GuildCallTriger)

function confirmUse(player,data)
	local guild_name = player:get_guild()
	if guild_name == "" then
		player:alert(1,1,"当前尚未拥有公会,不能使用!")
		return 0
	end
	local guild = server.find_guild(guild_name)
	if guild then
		if player:num_item("公会召集令") >= 1 then
			player:remove_item("公会召集令",1);
			local px,py = player:get_pos();
			--
			guild:guild_exe("item.chufa.guildMemberCall",player:get_name(),player:get_map():get_id(),px,py)
		else
			player:alert(1,1,"对不起,您的背包没有公会召集令!");
		end
	end
end


function guildMemberCall(player,pname,pmapid,nullparam,px,py)
	local guild_name = player:get_guild()
	if guild_name == "" then
		return 0
	end
	local selfx,selfy = player:get_pos();
	if player:get_map():get_id() == pmapid and selfx == px and selfy == py then
		return 0
	end
	local actionData = {src="item.chufa.GuildCallTriger",data={cmd="memcall",mid=pmapid,mx=px,my=py}}
	util.prompt(player,{msg=pname.."使用 公会召集令 请求您前往相助,是否前往?",okTitle="前  往",actionData=actionData})
	return 0;
end


function confirmMemEnter(player,data)
	local guild_name = player:get_guild()
	if guild_name == "" then
		player:alert(1,1,"当前尚未拥有公会,不能使用!")
		return 0
	end
	local guild = server.find_guild(guild_name)
	if guild then
		if data.mid and data.mx and data.my then
			local tmap = server.find_map(data.mid)
			if tmap then
				local fx,fy =  tmap:gen_rand_pos(data.mx,data.my,5);
				player:enter_map(data.mid,fx,fy)
			end
		end
	end
end
--------------------------------------------护具碎片
local tab_hjsp = {"护肩碎片","护腿碎片","吊坠碎片","面甲碎片"}
function hjspfd(player,item_name,item_id,num, pos)
	local bags = math.min(#tab_hjsp,num)
	if player:num_bag_black() >= bags then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_SPFUDAI) then
			math.random(#tab_hjsp)
			math.random(#tab_hjsp)
			math.random(#tab_hjsp)
			if num > 1 then
				local tmp = {}
				for i=1,num do
					table.insert(tmp,tab_hjsp[math.random(#tab_hjsp)])
				end
				for k,v in ipairs(tmp) do
					player:c_item(consrc.CITEM_ADD_SPFUDAI,v,1,1,"碎片福袋")
					player:alert(1,1,"打开碎片福袋，获得"..v.."*1")
				end 
			else 
				local bs = tab_hjsp[math.random(#tab_hjsp)]
				player:c_item(consrc.CITEM_ADD_SPFUDAI,bs,1,1,"碎片福袋")
				player:alert(1,1,"打开碎片福袋，获得"..bs)
			end 
		end
	else
		player:alert(1,1,"背包不足"..bags.."格，无法使用")
		return 0
	end 
	return 0
end 
-----------------------------护具宝箱
local hjbx={
	["荣耀护具宝箱"]={"荣耀护肩","荣耀护腿","荣耀吊坠","荣耀面甲"},
	["神圣护具宝箱"]={"神圣护肩","神圣护腿","神圣吊坠","神圣面甲"},
	["上古护具宝箱"]={"上古护肩","上古护腿","上古吊坠","上古面甲"},
	["昆吾护具宝箱"]={"昆吾护肩","昆吾护腿","昆吾吊坠","昆吾面甲"},
	["太虚护具宝箱"]={"太虚护肩","太虚护腿","太虚吊坠","太虚面甲"},
}

function hujubox(player,item_name,item_id,num, pos)
	local hy = hjbx[item_name]
	if hy then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_HUJUBOX) then
			math.random(#hy)
			math.random(#hy)
			math.random(#hy)
			local it = hy[math.random(#hy)]
			player:c_item(consrc.CITEM_ADD_HUJUBOX,it,1,0,"护具宝箱")
			player:alert(1,1,"成功打开"..item_name.."，获得"..it.."*1")
		end
	end	
	return 0
end
---------------------------------------纵横宝箱
function zhbox(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_ZHBOX) then
		player:c_item(consrc.CITEM_ADD_ZHBOX,"纵横天下神戒",1,0,"纵横宝箱")
		player:c_item(consrc.CITEM_ADD_ZHBOX,"纵横天下神镯",1,0,"纵横宝箱")
		player:alert(1,1,"成功打开"..item_name.."，获得纵横天下神戒，神镯")
	end
	return 0
end 

---------------------矿石------------------------
local k_data={
	["金钻矿石"]={"麻痹戒指碎片","复活戒指碎片","护身戒指碎片"},
	["元宝矿石"]={"护肩碎片","护腿碎片","吊坠碎片","面甲碎片"},
	["经验矿石"]={"护肩碎片","护腿碎片","吊坠碎片","面甲碎片"},
	["材料矿石"]={
		[1] = {"转生经验丹(小)","护盾碎片(小)","护符碎片(小)","初级强化石","羽毛","初级战神升阶丹","护体精元"},
		[2] = {"护肩碎片","护腿碎片","吊坠碎片","面甲碎片"}
	},
	["宝石矿石"]={
		[1] = {"一级攻击宝石","一级物防宝石","一级魔防宝石","一级生命宝石"},
		[2] = {"麻痹戒指碎片","复活戒指碎片","护身戒指碎片"},
	},
}

function kuang_yb(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_KUANG) then
		local sum = 0
		for i=1,num do
			sum = sum + math.random(1,15)
		end 
		player:add_vcoin_best_enable(sum,consrc.VCOIN_ADD_BY_KUANG)
		player:alert(1,1,"成功使用"..num.."个金钻矿石，获得金钻*"..sum)
		math.random(2000)
		math.random(2000)
		for j=1,num do 
			local rand = math.random(2000)
			if rand == 1 then
				local tab = k_data[item_name]
				local iitem = tab[math.random(#tab)]
				player:c_item(consrc.CITEM_ADD_BY_KUANG,iitem,1,1,""..item_name)
				player:alert(1,1,"恭喜您成功打开金钻矿石，运气爆棚，获得"..iitem.."*1")
				server.info(10010,0,"玩家<font color='#FF8A01'>"..player:get_name().."</font>使用<font color='#ff0000'>"..item_name.."</font>，运气爆棚，获得"..iitem)
			end
		end 
	end
	return 0
end
function kuang_jb(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_KUANG) then
		local sum = 0
		for i=1,num do
			sum = sum + math.random(10,50)
		end 
		player:add_gamemoney(sum*10000)
		player:alert(1,1,"成功使用"..num.."个元宝矿石，获得元宝*"..(sum*10000))
		math.random(888)
		math.random(888)
		for j=1,num do 
			local rand = math.random(888)
			if rand == 1 then
				local tab = k_data[item_name]
				local iitem = tab[math.random(#tab)]
				player:c_item(consrc.CITEM_ADD_BY_KUANG,iitem,1,1,""..item_name)
				player:alert(1,1,"恭喜您成功打开元宝矿石，运气爆棚，获得"..iitem.."*1")
				server.info(10010,0,"玩家<font color='#FF8A01'>"..player:get_name().."</font>使用<font color='#ff0000'>"..item_name.."</font>，运气爆棚，获得"..iitem)
			end
		end 
	end
	return 0
end
function kuang_jy(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_KUANG) then
		local sum = 0
		for i=1,num do
			sum = sum + math.random(100,200)
		end 
		player:add_exp(sum*10000)
		player:alert(1,1,"成功使用"..num.."个经验矿石，获得经验*"..(sum*10000))
		math.random(888)
		math.random(888)
		for j=1,num do 
			local rand = math.random(888)
			if rand == 1 then
				local tab = k_data[item_name]
				local iitem = tab[math.random(#tab)]
				player:c_item(consrc.CITEM_ADD_BY_KUANG,iitem,1,1,""..item_name)
				player:alert(1,1,"恭喜您成功打开经验矿石，运气爆棚，获得"..iitem.."*1")
				server.info(10010,0,"玩家<font color='#FF8A01'>"..player:get_name().."</font>使用<font color='#ff0000'>"..item_name.."</font>，运气爆棚，获得"..iitem)
			end
		end 
	end
	return 0
end
function kuang_cl(player,item_name,item_id,num, pos)
	if player:num_bag_black() >= 1 then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_KUANG) then
			math.random(300)
			math.random(300)
			local base = math.random(300)
			if base > 100 then
				player:add_exp(1000000)
				player:alert(1,1,"成功使用"..num.."个材料矿石，获得经验*"..(1000000))
			else
				local cls = k_data[item_name][1]
				local icl = cls[math.random(#cls)]
				player:c_item(consrc.CITEM_ADD_BY_KUANG,icl,1,1,""..item_name)
				player:alert(1,1,"成功使用"..num.."个材料矿石，获得材料 "..icl)
			end 
			math.random(888)
			math.random(888)
			local rand = math.random(888)
			if rand == 1 then
				local tab = k_data[item_name][2]
				local iitem = tab[math.random(#tab)]
				player:c_item(consrc.CITEM_ADD_BY_KUANG,iitem,1,1,""..item_name)
				player:alert(1,1,"恭喜您成功打开材料矿石，运气爆棚，获得"..iitem.."*1")
				server.info(10010,0,"玩家<font color='#FF8A01'>"..player:get_name().."</font>使用<font color='#ff0000'>"..item_name.."</font>，运气爆棚，获得"..iitem)
			end
		end
	else
		player:alert(1,1,"背包不足1格，无法使用")
		return 0
	end 
	return 0
end
function kuang_bs(player,item_name,item_id,num, pos)
	if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_KUANG) then
		local gets = {0,0,0,0}
		local cls = k_data[item_name][1]
		for i=1,num do
			local ra = math.random(#cls)
			gets[ra] = gets[ra] + 1
		end 
		local str = ""
		for k,v in ipairs(gets) do 
			if v > 0 then
				player:c_item(consrc.CITEM_ADD_BY_KUANG,cls[k],v,1,""..item_name)
				str = str..cls[k].."*"..v.." "
			end 
		end 
		player:alert(1,1,"成功使用"..num.."个宝石矿石，获得"..str)
		math.random(2000)
		math.random(2000)
		for j=1,num do 
			local rand = math.random(2000)
			if rand == 1 then
				local tab = k_data[item_name][2]
				local iitem = tab[math.random(#tab)]
				player:c_item(consrc.CITEM_ADD_BY_KUANG,iitem,1,1,""..item_name)
				player:alert(1,1,"恭喜您成功打开宝石矿石，运气爆棚，获得"..iitem.."*1")
				server.info(10010,0,"玩家<font color='#FF8A01'>"..player:get_name().."</font>使用<font color='#ff0000'>"..item_name.."</font>，运气爆棚，获得"..iitem)
			end
		end 
	end
	return 0
end
function bgfudai(player,item_name,item_id,num, pos)
	if player:num_bag_black() >= 1 then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_KUANG) then
			math.random(1000)
			math.random(1000)
			local base = math.random(1000)
			if base <= 500 then
				local vb = math.random(500,1500)
				player:add_vcoin_bind(vb)
				player:alert(1,1,"成功使用"..num.."个八卦福袋，获得降魔币*"..vb)
			elseif base > 500 and base <= 800 then
				local mb = math.random(50,100)
				player:add_gamemoney(mb*10000)
				player:alert(1,1,"成功使用"..num.."个八卦福袋，获得元宝"..mb.."万")
			else 
				local tabs = {"初级强化石","转生经验丹(小)","护盾碎片(中)","护符碎片(中)","经验葫芦(初级)","经验丹(大)"}
				local rand = math.random(#tabs)
				local num = 1
				if rand == 1 then
					num = 5
				end 
				player:c_item(consrc.CITEM_ADD_BY_BAGUA_FUDAI,tabs[rand],num,1,"八卦福袋")
				player:alert(1,1,"恭喜您成功打开八卦福袋，获得"..tabs[rand].."*"..num)
			end 
		end
	else
		player:alert(1,1,"背包不足1格，无法使用")
		return 0
	end 
	return 0
end
function tgbox(player,item_name,item_id,num, pos)
	if player:num_bag_black() >= 1 then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_KUANG) then
			local tab_gem1 = {"一级攻击宝石","一级物防宝石","一级魔防宝石","一级生命宝石"}
			local tab_gem2 = {"二级攻击宝石","二级物防宝石","二级魔防宝石","二级生命宝石"}
			local tab_gem3 = {"三级攻击宝石","三级物防宝石","三级魔防宝石","三级生命宝石"}
			math.random(1000)
			math.random(1000)
			for i=1,num do
				local base = math.random(1000)
				if base <= 800 then
					local gem = tab_gem1[math.random(#tab_gem1)]
					player:c_item(consrc.CITEM_ADD_BY_TIANGUAN_BOX,gem,1,0,"天关宝箱")
					player:alert(1,1,"成功使用天关宝箱，获得"..gem.."*1")
				elseif base > 800 and base <= 950 then
					local gem = tab_gem2[math.random(#tab_gem2)]
					player:c_item(consrc.CITEM_ADD_BY_TIANGUAN_BOX,gem,1,0,"天关宝箱")
					player:alert(1,1,"成功使用天关宝箱，获得"..gem.."*1")
				else 
					local gem = tab_gem3[math.random(#tab_gem3)]
					player:c_item(consrc.CITEM_ADD_BY_TIANGUAN_BOX,gem,1,0,"天关宝箱")
					player:alert(1,1,"成功使用天关宝箱，获得"..gem.."*1")
				end
			end 
		end
	else
		player:alert(1,1,"背包不足1格，无法使用")
		return 0
	end 
	return 0
end
--增加公会资金1000
function guildzijin1000(player,item_name,item_id,num, pos)
	if newgui.PanelGuild and newgui.PanelGuild.addGuildPoint then
		if newgui.PanelGuild.addGuildPoint(player,1000) then
			player:alert(1,1,"使用成功，公会资金增加1000")
			return
		end
	end
	return 0
end
---------------------神佑石头------------------------
local systone = {"破军神佑石","永生神佑石","金刚神佑石","鬼泣神佑石"}
local syitem={
	["神佑石福袋"]={limit=1},
	["神佑石宝箱(小)"]={limit=5},
	["神佑石宝箱(中)"]={limit=25},
	["神佑石宝箱(大)"]={limit=100},
	["神佑石宝箱(超)"]={limit=200},
	["神佑石宝箱(极)"]={limit=500},
}

function shenyou(player,item_name,item_id,num, pos)
	local sy = syitem[item_name]
	if sy then
		if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_SHENYOU_BOX) then
			local str = ""
			local itemNums = {}
			for i=1,num do
				local rd = math.random(#systone)
				itemNums[systone[rd]] = (itemNums[systone[rd]] or 0) + sy.limit
				player:c_item(consrc.CITEM_ADD_SHENYOU_STONE,systone[rd],sy.limit,1,"神佑礼包")
			end
			player:alert(1,1,"成功使用"..item_name.."*"..num)
			for k,v in pairs(itemNums) do
				player:alert(1,1,"获得"..k.."*"..v)
			end
		end
	end
	return 0
end
--中秋月饼
function zqyuebing(player,item_name,item_id,num, pos)
	if newgui.ActivityModule.isModuleOpen(player,"mShop") then
		util.openPanel(player,"Panel_module_activity",{actFlag="mShop"})
	else
		player:alert(1,1,"活动尚未开启.可至[道具回收员]处兑换元宝")
	end
	return 0
end
--中秋月饼
function zqlihe(player,item_name,item_id,num, pos)
	if newgui.ActivityModule.isModuleOpen(player,"mLihe") then
		util.openPanel(player,"Panel_module_activity",{actFlag="mLihe"})
	else
		player:alert(1,1,"活动尚未开启.可至[道具回收员]处兑换元宝")
	end
	return 0
end
---------------------神佑石头------------------------
local smlb={
	["国庆神秘礼包1"]={usetime=20181001,items={{item="神佑石宝箱(极)",num=1},}},
	["国庆神秘礼包2"]={usetime=20181002,items={{item="羽毛",num=88},}},
	["国庆神秘礼包3"]={usetime=20181003,items={{item="九级宝石宝箱",num=1},}},
	["国庆神秘礼包4"]={usetime=20181004,items={{item="护具碎片福袋",num=2},}},
	["国庆神秘礼包5"]={usetime=20181005,items={{item="特戒碎片礼包",num=1},}},
	["国庆神秘礼包6"]={usetime=20181006,items={{item="护体神丹(高级)",num=2},}},
	["国庆神秘礼包7"]={usetime=20181007,items={{item="荣耀护具宝箱",num=1},}},
	["国庆神秘礼包8"]={usetime=20181008,items={{item="超级祝福油",num=1},}},
}

function smlibao(player,item_name,item_id,num, pos)
	local sy = smlb[item_name]
	if sy then
		local nowDate = tonumber(os.date("%Y%m%d"))
		if nowDate >= sy.usetime then
			if 0 == player:remove_item_by_type_pos(item_id, pos, num,consrc.ITEM_REMOVE_SMLIBAO) then
				player:alert(1,1,"成功使用"..item_name.."*"..num)
				for k,v in ipairs(sy.items) do
					player:c_item(consrc.CITEM_ADD_SMLIBAO_OPEN,v.item,v.num,1,"神秘礼包")
					player:alert(1,1,"获得"..v.item.."*"..v.num)
				end
			end
		else
			player:alert(1,1,"未到使用时间，无法使用")
			return 0
		end
	end
	return 0
end

--铜质生肖礼券
function tzsxlq(player,item_name,item_id,num, pos)
	local items = {"铜质生肖(鼠)","铜质生肖(牛)","铜质生肖(虎)","铜质生肖(兔)","铜质生肖(龙)","铜质生肖(蛇)","铜质生肖(马)","铜质生肖(羊)","铜质生肖(猴)","铜质生肖(鸡)","铜质生肖(狗)","铜质生肖(猪)",}
	if player:num_bag_black() >= 1 then
		local rd = math.random(1,#items)
		player:c_item(consrc.CITEM_ADD_SHIERSXLQ,items[rd],1,0,"铜质生肖礼券")
		player:alert(1,1,"使用成功，获得1个 "..items[rd])
		return 1
	else
		player:alert(1,1,"背包不足1格，无法使用")
	end
	return 0
end
--银质生肖礼券
function yzsxlq(player,item_name,item_id,num, pos)
	local items = {"银质生肖(鼠)","银质生肖(牛)","银质生肖(虎)","银质生肖(兔)","银质生肖(龙)","银质生肖(蛇)","银质生肖(马)","银质生肖(羊)","银质生肖(猴)","银质生肖(鸡)","银质生肖(狗)","银质生肖(猪)",}
	if player:num_bag_black() >= 1 then
		local rd = math.random(1,#items)
		player:c_item(consrc.CITEM_ADD_SHIERSXLQ,items[rd],1,0,"银质生肖礼券")
		player:alert(1,1,"使用成功，获得1个 "..items[rd])
		return 1
	else
		player:alert(1,1,"背包不足1格，无法使用")
	end
	return 0
end
--金质生肖礼券
function jzsxlq(player,item_name,item_id,num, pos)
	local items = {"金质生肖(鼠)","金质生肖(牛)","金质生肖(虎)","金质生肖(兔)","金质生肖(龙)","金质生肖(蛇)","金质生肖(马)","金质生肖(羊)","金质生肖(猴)","金质生肖(鸡)","金质生肖(狗)","金质生肖(猪)",}
	if player:num_bag_black() >= 1 then
		local rd = math.random(1,#items)
		player:c_item(consrc.CITEM_ADD_SHIERSXLQ,items[rd],1,0,"金质生肖礼券")
		player:alert(1,1,"使用成功，获得1个 "..items[rd])
		return 1
	else
		player:alert(1,1,"背包不足1格，无法使用")
	end
	return 0
end
--秋风大礼包
function qiufengdlb(player,item_name,item_id,num, pos)
	activity.LiBaoQiRi.openLiBao(player)
	return 0
end