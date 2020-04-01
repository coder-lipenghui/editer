/**Created by the Morn,do not modify.*/
package view.auto.common {
	import morn.core.components.*;
	public class DialogWelcomUI extends Dialog {
		public var btn_start:Button = null;
		public var txt_path:TextInput = null;
		public var btn_browse:Button = null;
		public var btn_newProject:Button = null;
		protected static var uiXML:XML =
			<Dialog width="500" height="300">
			  <Image skin="png.comp.img_dialog" x="10" y="10" sizeGrid="22,22,22,22" left="0" right="0" top="0" bottom="0"/>
			  <Button label="打开" skin="png.comp.btn_small_primary" x="417" y="255" var="btn_start" right="20" bottom="15" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="267" y="255" name="close" bottom="15" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Image skin="png.comp.img_container" x="20" y="50" width="161" height="192" sizeGrid="40,5,5,5" left="20" top="50"/>
			  <Label text="最近" x="36" y="39" color="0xffffff"/>
			  <Label text="欢迎" x="12" y="11" color="0x212121" centerX="0" top="1"/>
			  <Image skin="png.comp.img_container" x="190" y="50" width="291" height="192" sizeGrid="40,5,5,5" left="190" top="50" right="20"/>
			  <TextInput skin="png.comp.textinput" x="202" y="117" margin="2" var="txt_path" width="212" height="22" color="0xFFFFFF"/>
			  <Label text="打开" x="200" y="41" color="0xffffff"/>
			  <Button label="浏览" skin="png.comp.btn_small_secondary" x="422" y="113" var="btn_browse" sizeGrid="19,0,19,0" width="50" height="30" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Button label="新增" skin="png.comp.btn_small_secondary" x="342" y="255" bottom="15" var="btn_newProject" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			</Dialog>;
		public function DialogWelcomUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}