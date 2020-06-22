/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogConverDirUI extends Dialog {
		public var btn_start:Button = null;
		public var txt_file:TextInput = null;
		public var btn_select:Button = null;
		public var ck_batch:CheckBox = null;
		protected static var uiXML:XML =
			<Dialog width="450" height="250">
			  <Image skin="png.comp.img_dialog" x="0" y="10" sizeGrid="22,22,22,22" left="0" right="0" top="0" bottom="0"/>
			  <Image skin="png.comp.img_container" x="12.5" y="49" width="425" height="156" sizeGrid="40,5,5,5"/>
			  <Button label="开 始" skin="png.comp.btn_small_primary" x="367" y="211" var="btn_start" right="20" bottom="15" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Label text="8方向转5方向" x="186" y="1" color="0x212121" centerX="0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="297" y="211" name="close" bottom="15" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <TextInput skin="png.comp.textinput" x="79" y="104" var="txt_file" width="231" height="22" color="0xFFFFFF" margin="2,2"/>
			  <Label text="目录" x="45" y="105" color="0xdbdbdb"/>
			  <Button label="浏览" skin="png.comp.btn_small_secondary" x="371" y="100" var="btn_select" width="50" height="30" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <CheckBox label="批量" skin="png.comp.checkbox" x="314" y="106" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0" var="ck_batch"/>
			  <Label text="基础" x="26" y="39" color="0xffffff"/>
			  <TextArea text="会删掉三个方向资源，8方向资源务必先做好备份" skin="png.comp.textarea" x="24" y="157" width="404" height="38" isHtml="true" selectable="false" editable="false" color="0xcccccc"/>
			</Dialog>;
		public function DialogConverDirUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}