/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogAddMonUI extends Dialog {
		public var btn_add:Button = null;
		public var txt_number:TextInput = null;
		public var txt_range:TextInput = null;
		public var txt_refTime:TextInput = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="200">
			  <Image skin="png.comp.img_dialog" x="20" y="20" sizeGrid="22,22,22,22" left="0" right="0" top="0" bottom="0"/>
			  <Label text="新增怪物" x="22" y="21" color="0x212121" centerX="0" top="1"/>
			  <Image skin="png.comp.img_container" x="190" y="50" sizeGrid="40,5,5,5" left="20" top="40" right="20" bottom="50"/>
			  <Label text="基础属性" x="35" y="32" color="0xffffff"/>
			  <Button label="确认" skin="png.comp.btn_small_primary" x="427" y="265" var="btn_add" right="20" bottom="15" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="247" y="155" name="close" bottom="15" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="119" y="57" margin="2" var="txt_number" width="175" height="22" text="1" color="0xFFFFFF"/>
			  <Label text="生成数量" x="54" y="58.5" color="0xbdbdbd"/>
			  <TextInput skin="png.comp.textinput" x="119" y="87" margin="2" var="txt_range" width="175" height="22" text="1" color="0xFFFFFF"/>
			  <Label text="活动范围" x="54" y="88.5" color="0xbdbdbd"/>
			  <TextInput skin="png.comp.textinput" x="119" y="117" margin="2,2,30,2" var="txt_refTime" width="175" height="22" text="100" color="0xFFFFFF"/>
			  <Label text="刷新时间" x="54" y="118.5" color="0xbdbdbd"/>
			  <Label text="(毫秒)" x="254" y="117" color="0xbdbdbd"/>
			</Dialog>;
		public function DialogAddMonUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}