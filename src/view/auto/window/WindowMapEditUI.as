/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class WindowMapEditUI extends View {
		public var img_mask:Image = null;
		public var cb_drawType:ComboBox = null;
		public var txt_point:Label = null;
		public var txt_scale:Label = null;
		public var cb_editType:ComboBox = null;
		public var input_scale:TextInput = null;
		public var pro_loaded:ProgressBar = null;
		public var cb_config:ComboBox = null;
		public var btn_export:Button = null;
		public var cb_object:ComboBox = null;
		public var box_obj:Box = null;
		public var list_object:List = null;
		public var txt_mapName:Label = null;
		public var btn_clean:Button = null;
		protected static var uiXML:XML =
			<View width="840" height="583">
			  <Image skin="png.comp.blank" var="img_mask" left="2" right="2" top="1" bottom="1"/>
			  <Image skin="png.comp.blank" x="0" y="0" left="0" right="0" top="0" height="24"/>
			  <ComboBox labels="路点,阻挡,遮罩" skin="png.comp.combobox" x="305" y="1" selectedIndex="1" var="cb_drawType" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0" sizeGrid="20,0,30,0"/>
			  <Label text="画笔" x="276" y="2" color="0x99ff"/>
			  <Label text="当前坐标:" x="375" y="2.5" color="0x99ff"/>
			  <Label text="999,999" x="430" y="3" color="0xffcc00" var="txt_point" width="53" height="18"/>
			  <LinkButton label="操作说明" right="1" top="1" toolTip="&lt;b>绘图模式:&lt;/b>&lt;br/>|-ctrl+1 切换到绘图模式&lt;br/>|-ctrl+2 切换到布局模式&lt;br/>|-alt+鼠标点击 画直线，可连续点&lt;br/>|-shift+1 切换到路点(橡皮)画笔&lt;br/>|-shift+2 切换到阻挡画笔&lt;br/>|-ctrl+z 撤销上一步操作&lt;br/>|-ctrl+s 保存&lt;br/>&lt;b>布局模式:&lt;/b>&lt;br/>|-ctrl+v 复制当前选中对象&lt;br/>|-delete 删除当前选中对象&lt;br/>|-鼠标按住拖动 可调整选中对象坐标&lt;br/>&lt;b>通用:&lt;/b>&lt;br/>|-右键按住 拖动地图&lt;br/>|-滚轮滚动 缩放地图&lt;br/>" x="563" y="1"/>
			  <Label text="当前缩放:" x="479" y="2.5" color="0x99ff"/>
			  <Label text="1.0" x="539" y="2" color="0xffcc00" var="txt_scale" width="35" height="18"/>
			  <ComboBox labels="绘图,布局" skin="png.comp.combobox" x="203" y="1" selectedIndex="0" var="cb_editType" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0" sizeGrid="20,0,30,0"/>
			  <Label text="模式" x="174" y="2" color="0x99ff"/>
			  <TextInput text="2" skin="png.comp.textinput" x="537" y="1" var="input_scale" width="36" height="22" color="0xFFFFFF" margin="2,2"/>
			  <ProgressBar skin="png.comp.progress" x="170" y="173" var="pro_loaded" visible="false" bottom="1" left="2" right="2" sizeGrid="2,2,2,2"/>
			  <ComboBox labels="全部导出,NPC配置,刷怪配置,传送点配置,地图配置" skin="png.comp.combobox" x="631" y="1" selectedIndex="0" var="cb_config" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0" width="92" height="22" sizeGrid="20,0,30,0"/>
			  <Button label="导出" skin="png.comp.button" x="726" y="1" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" var="btn_export" toolTip="ctrl+shift+t"/>
			  <ComboBox labels="--无--,怪物,NPC,传送" skin="png.comp.combobox" x="100" y="1" selectedIndex="0" var="cb_object" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0" height="22" sizeGrid="20,0,30,0"/>
			  <Label text="对象" x="71" y="2" color="0x99ff"/>
			  <Box x="-236" y="30" bottom="0" top="21" left="0" width="120" mouseEnabled="false" visible="false" var="box_obj">
			    <Image skin="png.comp.bg" left="0" right="0" top="0" bottom="0" alpha="0.2"/>
			    <List left="0" right="0" top="0" bottom="0" x="101" y="13" var="list_object" visible="true" vScrollBarSkin="png.comp.vscroll">
			      <Box name="render">
			        <Clip skin="png.comp.clip_select" name="selectBox" clipY="2" top="0" bottom="0" alpha="0.2" width="140"/>
			        <Label text="label" width="140" color="0xffffff" name="txt_name" x="2" y="1" height="20"/>
			      </Box>
			    </List>
			  </Box>
			  <Label text="配置文件:" x="579" y="2" color="0x99ff"/>
			  <Label text="地图名称" x="1" y="0" color="0xffffff" var="txt_mapName" stroke="0x0"/>
			  <Button label="清空" skin="png.comp.button" x="773" y="541" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" var="btn_clean" toolTip="ctrl+shift+t" bottom="15" right="1"/>
			</View>;
		public function WindowMapEditUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}