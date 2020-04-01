/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogJiuYinResGroupUI extends Dialog {
		public var btn_ok:Button = null;
		public var txt_path:TextInput = null;
		public var btn_browse:Button = null;
		public var ck_batch:CheckBox = null;
		public var txt_msg:Label = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="200">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" sizeGrid="22,22,22,22" x="30" y="50"/>
			  <Button label="确认" skin="png.comp.btn_small_primary" x="572" y="407" var="btn_ok" labelBold="false" right="10" bottom="10" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="502" y="407" sizeGrid="19,0,19,0" name="close" right="80" bottom="10" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="资源分类" color="0x212121" centerX="0" top="1" x="40" y="40"/>
			  <Box centerX="0" right="15" left="15" x="15" y="44">
			    <Image skin="png.comp.img_container" y="12" sizeGrid="40,5,5,5" width="370" height="80" x="0"/>
			    <Label text="分类" x="12" color="0xe0e0e0"/>
			    <Label x="17" y="21" width="326" height="20" color="0xcccccc" text="单目录内的（N_N^N）格式的资源进行归类及改名"/>
			    <TextInput skin="png.comp.textinput" x="51" y="46" margin="2" var="txt_path" width="197" height="22" color="0xFFFFFF"/>
			    <Label text="资源" x="17" y="47" color="0xbdbdbd"/>
			    <Button label="浏览" skin="png.comp.btn_small_secondary" x="303" y="42" var="btn_browse" sizeGrid="19,0,19,0" width="50" height="30" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			    <CheckBox label="批量" skin="png.comp.check_dark" x="253" y="48" var="ck_batch" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			  </Box>
			  <Label x="17" y="137" width="367" height="20" color="0x99cc66" var="txt_msg"/>
			</Dialog>;
		public function DialogJiuYinResGroupUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}