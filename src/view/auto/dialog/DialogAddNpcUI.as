/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogAddNpcUI extends Dialog {
		public var btn_add:Button = null;
		public var txt_id:TextInput = null;
		public var txt_name:TextInput = null;
		public var txt_script:TextInput = null;
		public var txt_shopScript:TextInput = null;
		public var txt_dir:TextInput = null;
		public var txt_flyid:TextInput = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="300">
			  <Image skin="png.comp.img_dialog" x="40" y="40" sizeGrid="22,22,22,22" left="0" right="0" top="0" bottom="0"/>
			  <Label text="新增NPC" x="42" y="41" color="0x212121" centerX="0" top="1"/>
			  <Image skin="png.comp.img_container" x="10" y="30" sizeGrid="40,5,5,5" left="20" top="40" right="20" bottom="50"/>
			  <Label text="基础属性" x="23" y="24" color="0xffffff"/>
			  <Button label="确认" skin="png.comp.btn_small_primary" x="307" y="245" var="btn_add" right="20" bottom="15" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="237" y="245" name="close" bottom="15" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="129" y="57" margin="2" var="txt_id" width="175" height="22" color="0xFFFFFF"/>
			  <Label text="唯一编号" x="64" y="58" color="0xbdbdbd"/>
			  <TextInput skin="png.comp.textinput" x="129" y="87" margin="2" var="txt_name" width="175" height="22" color="0xFFFFFF"/>
			  <Label text="NPC名称" x="64" y="88" color="0xbdbdbd"/>
			  <TextInput skin="png.comp.textinput" x="129" y="117" margin="2,2,30,2" width="175" height="22" text="null" var="txt_script" color="0xFFFFFF"/>
			  <Label text="触发脚本" x="64" y="118" color="0xbdbdbd"/>
			  <TextInput skin="png.comp.textinput" x="129" y="147" margin="2,2,30,2" width="175" height="22" text="null" var="txt_shopScript" color="0xFFFFFF"/>
			  <Label text="商店脚本" x="64" y="148" color="0xbdbdbd"/>
			  <TextInput skin="png.comp.textinput" x="129" y="177" margin="2,2,30,2" width="175" height="22" text="4" var="txt_dir" color="0xFFFFFF"/>
			  <Label text="面        向" x="64" y="178" color="0xbdbdbd"/>
			  <TextInput skin="png.comp.textinput" x="129" y="207" margin="2,2,30,2" width="175" height="22" var="txt_flyid" text="0" color="0xFFFFFF"/>
			  <Label text="传从 ID" x="64" y="208" color="0xbdbdbd"/>
			</Dialog>;
		public function DialogAddNpcUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}