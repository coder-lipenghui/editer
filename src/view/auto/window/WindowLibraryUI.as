/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class WindowLibraryUI extends View {
		public var txt_search:TextInput = null;
		public var txt_placeholder:Label = null;
		public var btn_more:Button = null;
		public var tab_catalog:Tab = null;
		public var box:Box = null;
		protected static var uiXML:XML =
			<View width="230" height="350">
			  <Image skin="png.comp.img_bg" left="0" right="0" top="0" bottom="0" x="-10" y="-10" sizeGrid="10,22,10,10"/>
			  <Image skin="png.comp.bg" top="19" bottom="0" left="0" right="0" x="-10" y="9"/>
			  <Image skin="png.comp.img_bg" x="-543" y="199" left="0" width="20" top="0" bottom="0" sizeGrid="10,22,10,10"/>
			  <Box y="174" bottom="0" left="3" x="3" right="0">
			    <TextInput skin="png.comp.textinput" width="191" height="22" margin="25,2" right="2" left="-1" color="0xe0e0e0" var="txt_search" y="1"/>
			    <Image skin="png.comp.btn_search" scale="0.8" smoothing="true" stateNum="1"/>
			    <Label text="查  找" centerX="0" bottom="3" color="0x666666" mouseEnabled="false" var="txt_placeholder" x="96.5" y="3.6"/>
			  </Box>
			  <Tab labels="资源库" skin="png.comp.tab" selectedIndex="0" top="1" x="0" y="0" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			  <Button skin="png.comp.btn_action" x="210" y="0" stateNum="3" var="btn_more" right="0" top="0"/>
			  <Tab labels="角色,怪物,NPC,特效" skin="png.comp.tab_vertical" direction="vertical" left="0" top="22" x="0" y="20" space="1" var="tab_catalog" labelSize="12" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			  <Box x="0" y="0" left="21" right="0" top="23" bottom="22" var="box"/>
			</View>;
		public function WindowLibraryUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}