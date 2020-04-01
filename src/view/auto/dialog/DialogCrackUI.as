/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogCrackUI extends Dialog {
		public var btn_start:Button = null;
		public var txt_file:TextInput = null;
		public var btn_select:Button = null;
		public var ck_delete:CheckBox = null;
		public var txt_action:TextInput = null;
		protected static var uiXML:XML =
			<Dialog width="450" height="250">
			  <Image skin="png.comp.img_dialog" x="0" y="0" sizeGrid="22,22,22,22" left="0" right="0" top="0" bottom="0"/>
			  <Button label="开 始" skin="png.comp.btn_small_primary" x="329" y="210" var="btn_start" right="20" bottom="15" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Label text="bin文件拆分" x="2" y="1" color="0x212121" centerX="0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="297" y="210" name="close" bottom="15" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Image skin="png.comp.img_container" x="10" y="39" width="425" height="156" sizeGrid="40,5,5,5"/>
			  <TextInput skin="png.comp.textinput" x="69" y="94" var="txt_file" width="231" height="22" color="0xFFFFFF" margin="2,2"/>
			  <Label text="目录" x="35" y="95" color="0xdbdbdb"/>
			  <Button label="浏览" skin="png.comp.btn_small_secondary" x="371" y="90" var="btn_select" width="50" height="30" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <CheckBox label="批量" skin="png.comp.checkbox" x="304" y="96" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0"/>
			  <TextArea text="批量：单目录下所有的png+bin文件将被拆解&lt;br/>常规：选择单张PNG进行拆解，需要bin文件在同级目录" skin="png.comp.textarea" x="22" y="134" width="404" height="57" isHtml="true" selectable="false" editable="false"/>
			  <CheckBox label="完成后删除原文件" skin="png.comp.checkbox" x="304" y="61" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0" var="ck_delete"/>
			  <TextInput skin="png.comp.textinput" x="69" y="59" var="txt_action" width="231" height="22" text="待机,走路,跑步,准备,攻击,施法,受伤,死亡" color="0xcccccc" toolTip="按照“,”截取，顺序对应的动作" margin="2,2"/>
			  <Label text="动作" x="35" y="60.5" color="0xdbdbdb"/>
			  <Label text="基础" x="26" y="29" color="0xffffff"/>
			</Dialog>;
		public function DialogCrackUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}