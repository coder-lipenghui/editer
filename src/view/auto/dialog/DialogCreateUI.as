/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogCreateUI extends Dialog {
		public var btn_add:Button = null;
		public var txt_path:TextInput = null;
		public var btn_browse:Button = null;
		public var txt_name:TextInput = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="200">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" sizeGrid="22,22,22,22" x="20" y="20"/>
			  <Button label="创建" skin="png.comp.btn_small_primary" x="542" y="377" var="btn_add" labelBold="false" right="10" bottom="15" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="472" y="377" sizeGrid="19,0,19,0" name="close" right="80" bottom="15" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="新建项目" color="0x212121" centerX="0" top="1" x="10" y="10"/>
			  <Box centerX="0" right="15" left="15" x="15" y="40">
			    <Image skin="png.comp.img_container" y="10" sizeGrid="40,5,5,5" width="370" height="84" x="0"/>
			    <TextInput skin="png.comp.textinput" x="61" y="56" margin="2" var="txt_path" width="241" height="22" color="0xFFFFFF"/>
			    <Label text="目录" x="27" y="57" color="0xbdbdbd"/>
			    <Label text="新建" x="12" color="0xe0e0e0"/>
			    <Button label="浏览" skin="png.comp.btn_small_secondary" x="313" y="52" var="btn_browse" sizeGrid="19,0,19,0" width="50" height="30" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			    <Label text="名称" x="27" y="27" color="0xbdbdbd"/>
			    <TextInput skin="png.comp.textinput" x="61" y="26" margin="2" var="txt_name" width="241" height="22" color="0xFFFFFF"/>
			  </Box>
			  <Image skin="png.comp.img_splite" x="-4" y="106" left="0" top="0" bottom="0"/>
			  <Image skin="png.comp.img_splite_h" x="117" y="293" bottom="0" left="0" right="0"/>
			  <Image skin="png.comp.img_splite" x="497" y="158" right="0" top="0" bottom="0"/>
			</Dialog>;
		public function DialogCreateUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}