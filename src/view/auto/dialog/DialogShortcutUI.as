/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogShortcutUI extends Dialog {
		public var btn_ok:Button = null;
		public var list_shortcut:List = null;
		protected static var uiXML:XML =
			<Dialog width="600" height="400">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" x="20" y="20" sizeGrid="22,22,22,22"/>
			  <Image skin="png.comp.img_container" y="46" sizeGrid="40,5,5,5" width="561" height="305" x="23"/>
			  <Label text="快捷键设置" color="0x212121" centerX="0" top="1" x="20" y="20"/>
			  <Label text="地图编辑" x="35" color="0xe0e0e0" y="34"/>
			  <Button label="编辑" skin="png.comp.btn_small_primary" x="592" y="427" var="btn_ok" labelBold="false" right="10" bottom="10" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="522" y="427" sizeGrid="19,0,19,0" name="close" right="80" bottom="10" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <List x="29" y="59" width="544" height="288" spaceY="5" var="list_shortcut">
			    <Box name="render" x="-1" y="-1">
			      <Clip skin="png.comp.clip_select" name="selectBox" clipY="2" width="552" height="24"/>
			      <TextInput skin="png.comp.textinput" x="88" name="txt_key" width="422" height="22" editable="false" y="2" color="0xFFFFFF" margin="2,2"/>
			      <Label text="KEY" color="0xbdbdbd" y="3" x="1" width="85" height="18" align="right" name="txt_name"/>
			    </Box>
			  </List>
			  <Image skin="png.comp.img_splite_h" x="-388" y="77" left="0" right="0" bottom="0"/>
			  <Image skin="png.comp.img_splite" x="-98" y="-13" top="0" bottom="0" left="0"/>
			  <Image skin="png.comp.img_splite" x="-57" y="111" right="0" top="0" bottom="0"/>
			  <Label text="只能设置组合键:ctrl | shift+[0-1] 和 [a-z]。或者[F1-F12]" x="21" y="368" color="0x66ff33"/>
			</Dialog>;
		public function DialogShortcutUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}