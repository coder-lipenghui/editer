/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class WindowDropInfoUI extends View {
		public var box_container:Panel = null;
		public var txt_oldDrop:TextArea = null;
		protected static var uiXML:XML =
			<View width="200" height="400">
			  <Image skin="png.comp.img_bg" left="0" right="0" top="0" bottom="0" sizeGrid="10,22,10,10"/>
			  <Image skin="png.comp.bg" left="0" right="0" top="19" bottom="0" x="-787" y="330"/>
			  <Box bottom="3" left="5" visible="false">
			    <TextInput skin="png.comp.textinput" width="191" height="22" text="快捷查找" margin="25,2" color="0xe0e0e0"/>
			    <Button skin="png.comp.btn_zoom_out" x="2" y="2" stateNum="1"/>
			  </Box>
			  <Panel x="1862" y="1372" top="24" bottom="26" left="2" right="2" vScrollBarSkin="png.comp.vscroll" var="box_container"/>
			  <TextArea left="2" right="2" top="24" bottom="26" var="txt_oldDrop" vScrollBarSkin="png.comp.vscroll"/>
			  <Tab labels="掉落信息" skin="png.comp.tab" selectedIndex="0" left="0" top="1" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			</View>;
		public function WindowDropInfoUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}