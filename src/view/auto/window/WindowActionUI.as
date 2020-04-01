/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class WindowActionUI extends View {
		public var txt_name:TextInput = null;
		public var txt_path:TextInput = null;
		public var txt_dir:TextInput = null;
		public var txt_frameCount:TextInput = null;
		public var txt_centerX:TextInput = null;
		public var txt_centerY:TextInput = null;
		public var txt_renderTicket:TextInput = null;
		public var txt_playTime:TextInput = null;
		public var list_frame:List = null;
		public var txt_action:TextInput = null;
		public var btn_action:Button = null;
		public var tab_displayModel:Tab = null;
		protected static var uiXML:XML =
			<View width="200" height="600">
			  <Image skin="png.comp.img_bg" left="0" right="0" top="0" bottom="0" sizeGrid="10,22,10,10"/>
			  <Image skin="png.comp.bg" x="2" y="295" top="19" left="0" right="0" bottom="0" sizeGrid="2,2,2,2"/>
			  <Label text="文件名称" x="5" y="32" color="0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="62" y="31" var="txt_name" editable="false" color="0xFFFFFF" margin="2,2"/>
			  <Label text="素材分类" x="5" y="58" color="0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="62" y="57" var="txt_path" editable="false" disabled="true" color="0xFFFFFF" margin="2,2"/>
			  <Label text="方向总数" x="5" y="110" color="0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="62" y="109" var="txt_dir" color="0xFFFFFF" margin="2,2"/>
			  <Label text="动作帧数" x="5" y="136" color="0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="62" y="135" var="txt_frameCount" color="0xFFFFFF" margin="2,2"/>
			  <Label text="中心点X" x="5" y="162" color="0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="62" y="161" var="txt_centerX" color="0xFFFFFF" margin="2,2"/>
			  <Label text="中心点Y" x="5" y="188" color="0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="62" y="187" var="txt_centerY" color="0xFFFFFF" margin="2,2"/>
			  <Label text="游戏帧率" x="5" y="214" color="0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="62" y="213" var="txt_renderTicket" color="0xFFFFFF" margin="2,2"/>
			  <Label text="动过时长" x="5" y="240" color="0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="62" y="239" var="txt_playTime" editable="false" disabled="true" color="0xFFFFFF" margin="2,2"/>
			  <Image skin="png.comp.img_splite_h" x="0" y="272" left="0" right="0"/>
			  <List x="9" y="262" vScrollBarSkin="png.comp.vscroll" repeatY="15" left="5" right="5" var="list_frame" bottom="5" top="280" spaceY="1">
			    <Box name="render">
			      <Label text="动过时长" y="1" name="txt_id" color="0xFFFFFF"/>
			      <TextInput text="TextInput" skin="png.comp.textinput" x="57" name="txt_frame" y="0" width="116" height="22" color="0xFFFFFF" margin="2,2"/>
			    </Box>
			  </List>
			  <Label text="动作名称" x="5" y="84" color="0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="62" y="83" var="txt_action" color="0xFFFFFF" margin="2,2"/>
			  <Button skin="png.comp.btn_action" var="btn_action" right="0" top="0"/>
			  <Tab x="1" y="0" selectedIndex="0" var="tab_displayModel">
			    <Button label="外观" skin="png.comp.tab" sizeGrid="2,2,2,2,1" width="38" height="20" name="item0" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			    <Button label="武器" skin="png.comp.tab" x="40" sizeGrid="2,2,2,2,1" width="38" height="20" name="item1" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			    <Button label="翅膀" skin="png.comp.tab" x="80" sizeGrid="2,2,2,2,1" width="38" height="20" name="item2" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			    <Button label="特效" skin="png.comp.tab" x="120" sizeGrid="2,2,2,2,1" width="38" height="20" name="item3" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			  </Tab>
			</View>;
		public function WindowActionUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}