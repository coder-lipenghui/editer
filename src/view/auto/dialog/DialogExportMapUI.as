/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogExportMapUI extends Dialog {
		public var btn_export:Button = null;
		public var txt_mapId:TextInput = null;
		public var ck_mapo:CheckBox = null;
		public var ck_minimap:CheckBox = null;
		public var txt_msg:Label = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="200">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" sizeGrid="22,22,22,22" x="0" y="20"/>
			  <Button label="导出" skin="png.comp.btn_small_primary" x="542" y="377" var="btn_export" labelBold="false" right="10" bottom="15" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="472" y="377" sizeGrid="19,0,19,0" name="close" right="80" bottom="15" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="导出地图" color="0x212121" centerX="0" top="1" x="10" y="10"/>
			  <Box centerX="0" right="15" left="15" x="15" y="30">
			    <Image skin="png.comp.img_container" y="12" sizeGrid="40,5,5,5" width="370" height="80" x="0"/>
			    <Label text="导出" x="12" color="0xe0e0e0"/>
			    <TextInput skin="png.comp.textinput" x="90" y="34" margin="2" var="txt_mapId" width="256" height="22" color="0xFFFFFF"/>
			    <Label text="地图编号" x="27" y="35" color="0xbdbdbd"/>
			    <CheckBox skin="png.comp.checkbox" x="90" y="62.5" var="ck_mapo" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0"/>
			    <Label text="只导配置" x="27" y="61.5" color="0xbdbdbd"/>
			    <CheckBox skin="png.comp.checkbox" x="221" y="62" var="ck_minimap" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0"/>
			    <Label text="只导小地图" x="147" y="61" color="0xbdbdbd"/>
			  </Box>
			  <Label x="20.5" y="127" width="359" height="20" color="0x9933" var="txt_msg"/>
			</Dialog>;
		public function DialogExportMapUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}