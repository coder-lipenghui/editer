/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class WindowLogUI extends View {
		public var txt_filters:TextInput = null;
		public var btn_clean:Button = null;
		public var txt_log:TextArea = null;
		public var ck_scroll:CheckBox = null;
		protected static var uiXML:XML =
			<View width="600" height="150">
			  <Image skin="png.comp.img_bg" left="0" right="0" top="0" bottom="0" sizeGrid="10,22,10,10"/>
			  <Image skin="png.comp.bg" left="0" right="0" top="19" bottom="0" sizeGrid="2,2,2,2"/>
			  <Box y="124" x="332" bottom="4" right="2">
			    <TextInput skin="png.comp.textinput" width="191" height="22" margin="25,2" color="0xe0e0e0" var="txt_filters"/>
			    <Image skin="png.comp.btn_search" x="0" y="-1" scale="0.8" smoothing="true" stateNum="1"/>
			  </Box>
			  <Button skin="png.comp.btn_delete_w" x="306" y="212" stateNum="1" var="btn_clean" bottom="5" right="240"/>
			  <TextArea left="2" right="2" top="24" bottom="27" var="txt_log" isHtml="true" editable="false" color="0xffffff" x="2" y="24" width="596" height="96"/>
			  <Tab labels="控制台" skin="png.comp.tab" x="0" y="0" selectedIndex="0" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			  <CheckBox label="滚屏" skin="png.comp.checkbox" x="379" y="252" bottom="5" right="194" var="ck_scroll" selected="true" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0"/>
			</View>;
		public function WindowLogUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}