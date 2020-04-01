/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogExportResUI extends Dialog {
		public var btn_export:Button = null;
		public var txt_mapId:TextInput = null;
		public var ck_mapo:CheckBox = null;
		public var txt_msg:Label = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="200">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" sizeGrid="22,22,22,22" x="10" y="30"/>
			  <Button label="导出" skin="png.comp.btn_small_primary" x="552" y="387" var="btn_export" labelBold="false" right="10" bottom="10" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="482" y="387" sizeGrid="19,0,19,0" name="close" right="80" bottom="10" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="导出资源" color="0x212121" centerX="0" top="1" x="20" y="20"/>
			  <Box centerX="0" right="15" left="15" x="25" y="40">
			    <Image skin="png.comp.img_container" y="12" sizeGrid="40,5,5,5" width="370" height="80" x="0"/>
			    <Label text="导出" x="12" color="0xe0e0e0"/>
			    <TextInput skin="png.comp.textinput" x="90" y="34" margin="2" var="txt_mapId" width="256" height="22" color="0xFFFFFF"/>
			    <Label text="资源ID" x="27" y="35" color="0xbdbdbd"/>
			    <CheckBox skin="png.comp.checkbox" x="90" y="62.5" var="ck_mapo" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0"/>
			    <Label text="生成BIZ" x="27" y="61.5" color="0xbdbdbd"/>
			  </Box>
			  <Label x="15" y="137" width="359" height="20" color="0x9933" var="txt_msg"/>
			</Dialog>;
		public function DialogExportResUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}