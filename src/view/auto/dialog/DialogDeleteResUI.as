/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogDeleteResUI extends Dialog {
		public var btn_ok:Button = null;
		public var txt_msg:Label = null;
		public var ck_release:CheckBox = null;
		public var ck_library:CheckBox = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="200">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" sizeGrid="22,22,22,22" x="20" y="40"/>
			  <Button label="确认" skin="png.comp.btn_small_primary" x="562" y="397" var="btn_ok" labelBold="false" right="10" bottom="10" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="取消" skin="png.comp.btn_small_secondary" x="492" y="397" sizeGrid="19,0,19,0" name="close" right="80" bottom="10" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="删除资源" color="0x212121" centerX="0" top="1" x="30" y="30"/>
			  <Box centerX="0" right="15" left="15" x="14" y="44">
			    <Image skin="png.comp.img_container" y="12" sizeGrid="40,5,5,5" width="370" height="80" x="0"/>
			    <Label text="删除" x="12" color="0xe0e0e0"/>
			    <Label x="24" y="21" width="326" height="20" color="0xcccccc" var="txt_msg" text="是否删除资源?"/>
			    <CheckBox skin="png.comp.checkbox" x="27" y="68" var="ck_release" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0"/>
			    <Label text="删除Release中的资源" x="51" y="66" color="0xbdbdbd" width="150"/>
			    <CheckBox skin="png.comp.checkbox" x="27" y="47" var="ck_library" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0"/>
			    <Label x="51" y="44" width="150" height="20" color="0xcccccc" text="刪除资源库中的资源"/>
			  </Box>
			</Dialog>;
		public function DialogDeleteResUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}