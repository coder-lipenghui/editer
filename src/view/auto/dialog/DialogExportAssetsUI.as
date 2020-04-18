/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogExportAssetsUI extends Dialog {
		public var btn_ok:Button = null;
		public var txt_msg:Label = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="200">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" sizeGrid="22,22,22,22" x="40" y="60"/>
			  <Button label="确认" skin="png.comp.btn_small_primary" x="582" y="417" var="btn_ok" labelBold="false" right="10" bottom="10" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="取消" skin="png.comp.btn_small_secondary" x="512" y="417" sizeGrid="19,0,19,0" name="close" right="80" bottom="10" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="删除资源" color="0x212121" centerX="0" top="1" x="50" y="50"/>
			  <Box centerX="0" right="15" left="15" x="25" y="57">
			    <Image skin="png.comp.img_container" y="12" sizeGrid="40,5,5,5" width="370" height="80" x="0"/>
			    <Label text="导出资源" x="12" color="0xe0e0e0"/>
			    <Label x="24" y="41" width="326" height="20" color="0xcccccc" var="txt_msg" text="是否删除资源?"/>
			  </Box>
			</Dialog>;
		public function DialogExportAssetsUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}