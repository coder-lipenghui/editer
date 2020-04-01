/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class WindowProjectUI extends View {
		public var list_config:List = null;
		public var com_config:ComboBox = null;
		public var txt_search:TextInput = null;
		public var txt_placeholder:Label = null;
		public var tab_group:Tab = null;
		protected static var uiXML:XML =
			<View width="230" height="200">
			  <Image skin="png.comp.img_bg" left="0" right="0" top="0" bottom="0" sizeGrid="10,22,10,10"/>
			  <Image skin="png.comp.bg" left="0" right="0" top="19" bottom="0" sizeGrid="2,2,2,2"/>
			  <Panel left="0" right="0" top="22" bottom="26" vScrollBarSkin="png.comp.vscroll" hScrollBarSkin="png.comp.hscroll" x="20" y="20">
			    <List spaceY="1" top="26" left="5" var="list_config" vScrollBarSkin="png.comp.vscroll" bottom="0" x="5" y="26" right="3">
			      <Box name="render" height="24" left="2" right="2">
			        <Clip skin="png.comp.clip_select" name="selectBox" clipX="1" clipY="2" left="0" right="0" top="0" bottom="0"/>
			        <Label centerY="0" name="txt_name" width="163" height="20" isHtml="true" x="0" y="2" color="0xe0e0e0"/>
			      </Box>
			    </List>
			    <ComboBox skin="png.comp.combobox" sizeGrid="40,0,40,0" left="2" right="2" top="1" var="com_config" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			  </Panel>
			  <Box bottom="3" left="3" right="3">
			    <TextInput skin="png.comp.textinput" width="191" height="22" margin="25,2" left="0" right="1" var="txt_search" color="0xFFFFFF"/>
			    <Label text="查  找" centerX="0" bottom="2" color="0x666666" mouseEnabled="false" var="txt_placeholder"/>
			  </Box>
			  <Tab labels="配置,脚本" skin="png.comp.tab" var="tab_group" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0" left="0" top="0"/>
			  <Image skin="png.comp.btn_search" x="2" y="174" scale="0.8" smoothing="true" bottom="2" stateNum="1"/>
			</View>;
		public function WindowProjectUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}