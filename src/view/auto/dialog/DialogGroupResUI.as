/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogGroupResUI extends Dialog {
		public var txt_path:TextInput = null;
		public var btn_browse:Button = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="200">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" sizeGrid="22,22,22,22"/>
			  <Button label="确定" skin="png.comp.btn_small_primary" x="275" y="197" right="10" bottom="10" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="265" y="224" right="80" bottom="10" name="close" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="资源归类" color="0x212121" centerX="0" top="1"/>
			  <TextInput skin="png.comp.textinput" x="71" y="36" margin="2" var="txt_path" width="241" height="22" color="0xFFFFFF"/>
			  <Label text="资源" x="37" y="37" color="0xbdbdbd"/>
			  <Button label="浏览" skin="png.comp.btn_small_secondary" x="323" y="32" var="btn_browse" sizeGrid="19,0,19,0" width="50" height="30" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			</Dialog>;
		public function DialogGroupResUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}