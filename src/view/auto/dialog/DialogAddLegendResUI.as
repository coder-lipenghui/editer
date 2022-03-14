/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogAddLegendResUI extends Dialog {
		public var txt_path:TextInput = null;
		public var btn_browse:Button = null;
		public var txt_frame:TextInput = null;
		public var cb_dir:ComboBox = null;
		public var ck_batch:CheckBox = null;
		public var btn_ok:Button = null;
		protected static var uiXML:XML =
			<Dialog width="400" height="200">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" x="10" y="10" sizeGrid="22,22,22,22"/>
			  <Image skin="png.comp.img_container" y="36" sizeGrid="40,5,5,5" width="370" height="114" x="13"/>
			  <Label text="传奇资源" color="0x212121" centerX="0" top="1" x="10" y="10"/>
			  <TextInput skin="png.comp.textinput" x="79" y="62" margin="2" var="txt_path" width="199" height="22" color="0xFFFFFF"/>
			  <Label text="资源" x="45" y="63" color="0xbdbdbd"/>
			  <Button label="选择" skin="png.comp.btn_small_secondary" x="328" y="58" var="btn_browse" sizeGrid="19,0,19,0" width="50" height="30" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="路径" x="25" color="0xe0e0e0" y="24"/>
			  <TextInput skin="png.comp.textinput" x="79" y="92" width="240" height="22" toolTip="用&quot;,&quot;分隔" var="txt_frame" visible="false" color="0xFFFFFF" margin="2,2"/>
			  <ComboBox labels="8,5,3,1" skin="png.comp.combobox" x="79" y="152" var="cb_dir" selectedIndex="0" visible="false" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF" sizeGrid="20,0,30,0"/>
			  <Label text="帧数" x="45" y="93" color="0xbdbdbd" visible="false"/>
			  <Label text="方向数" x="33" y="153" color="0xbdbdbd" visible="false"/>
			  <TextInput skin="png.comp.textinput" x="79" y="122" width="240" toolTip="用&quot;,&quot;分隔，需要跟帧数对应起来" name="txt_name" visible="false" color="0xFFFFFF" margin="2,2"/>
			  <Label text="名称" x="45" y="123" color="0xbdbdbd" visible="false"/>
			  <CheckBox label="批量" skin="png.comp.checkbox" x="282" y="64" toolTip="批量需要将需要制作的单个资源文件夹放到同一个目录，然后选取这个目录进行制作" var="ck_batch" labelColors="0xE0E0E0,0xE0E0E0,0xE0E0E0"/>
			  <Button label="确认" skin="png.comp.btn_small_primary" x="582" y="417" var="btn_ok" labelBold="false" right="10" bottom="10" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="512" y="417" sizeGrid="19,0,19,0" name="close" right="80" bottom="10" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Image skin="png.comp.img_splite" x="-99" top="0" bottom="0" left="0"/>
			  <Image skin="png.comp.img_splite" x="860" y="-117" top="0" bottom="0" right="0"/>
			  <Image skin="png.comp.img_splite_h" x="-221" y="-167" left="0" right="0" bottom="0"/>
			</Dialog>;
		public function DialogAddLegendResUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}