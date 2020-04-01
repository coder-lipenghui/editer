/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class WindowPropertyUI extends View {
		public var box_container:Panel = null;
		protected static var uiXML:XML =
			<View width="200" height="600">
			  <Image skin="png.comp.img_bg" left="0" right="0" top="0" bottom="0" x="641" y="81" sizeGrid="10,22,10,10"/>
			  <Image skin="png.comp.bg" sizeGrid="2,2,2,2" left="0" right="0" top="19" bottom="0"/>
			  <Box bottom="3" left="3" right="3" x="10" y="10">
			    <TextInput skin="png.comp.textinput" text="快捷查找" margin="25,2" color="0xe0e0e0" left="0" right="0"/>
			    <Image skin="png.comp.btn_search" x="0" y="-1" scale="0.8" smoothing="true" stateNum="1"/>
			  </Box>
			  <Panel top="22" bottom="26" left="2" right="2" vScrollBarSkin="png.comp.vscroll" var="box_container"/>
			  <Tab labels="配置属性" skin="png.comp.tab" selectedIndex="0" left="0" top="0" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			</View>;
		public function WindowPropertyUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}