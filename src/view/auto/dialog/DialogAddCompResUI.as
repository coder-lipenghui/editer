/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogAddCompResUI extends Dialog {
		public var list_action:List = null;
		public var btn_add:Button = null;
		public var box_catalog:Box = null;
		public var txt_position:Label = null;
		public var txt_id:TextInput = null;
		public var txt_name:TextInput = null;
		public var txt_x:TextInput = null;
		public var txt_y:TextInput = null;
		public var cb_dirCount:ComboBox = null;
		public var com_moudle:ComboBox = null;
		public var btn_change:Button = null;
		public var box_effect_model:Box = null;
		public var cb_effect_action:ComboBox = null;
		public var check_rotaion:CheckBox = null;
		public var txt_path:TextInput = null;
		public var cb_batch:CheckBox = null;
		public var btn_browse:Button = null;
		protected static var uiXML:XML =
			<Dialog width="600" height="400">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" sizeGrid="22,22,22,22"/>
			  <LinkButton label="说明" x="19" y="360" bottom="15"/>
			  <Image skin="png.comp.img_container" x="390" y="46" sizeGrid="40,5,5,5" width="204" height="294"/>
			  <Label text="模板预览" x="407" y="36" color="0xe0e0e0"/>
			  <Box x="394" y="59">
			    <Label text="名称" x="47" color="0xbdbdbd" y="0"/>
			    <Label text="帧数" x="84" y="1" color="0xbdbdbd"/>
			    <Label text="矫正" x="132" y="2" color="0xbdbdbd"/>
			    <List x="3" y="25" vScrollBarSkin="png.comp.vscroll" spaceY="1" repeatY="10" width="192" height="252" var="list_action">
			      <Box name="render">
			        <TextInput skin="png.comp.textinput" margin="2" width="35" height="22" name="txt_id" color="0xbdbdbd"/>
			        <TextInput skin="png.comp.textinput" x="114" margin="2" y="0" width="59" height="22" name="txt_amendment" color="0xbdbdbd"/>
			        <TextInput skin="png.comp.textinput" x="36" margin="2" width="40" height="22" name="txt_name" y="0" color="0xbdbdbd"/>
			        <TextInput skin="png.comp.textinput" x="79" margin="2" y="0" width="32" height="22" name="txt_frame" color="0xbdbdbd"/>
			      </Box>
			    </List>
			    <Image skin="png.comp.img_splite_h" height="1" left="0" right="0" y="23"/>
			    <Label text="编号" x="7" y="1" color="0xbdbdbd"/>
			  </Box>
			  <Button label="添加" skin="png.comp.btn_small_primary" x="522" y="357" var="btn_add" labelBold="false" right="10" bottom="15" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="452" y="357" sizeGrid="19,0,19,0" name="close" right="80" bottom="15" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="添加资源" x="270" y="0" color="0x212121" centerX="0"/>
			  <Box x="11" y="107" var="box_catalog">
			    <Image skin="png.comp.img_container" y="10" sizeGrid="40,5,5,5" width="370" height="53" x="0"/>
			    <Label text="存储路径" x="12" color="0xe0e0e0"/>
			    <Label text="路径" x="27" y="27" color="0xbdbdbd" var="txt_position"/>
			  </Box>
			  <Box x="11" y="183">
			    <Image skin="png.comp.img_container" y="10" sizeGrid="40,5,5,5" width="370" height="146" x="0"/>
			    <TextInput skin="png.comp.textinput" x="61" y="56" margin="2" var="txt_id" width="80" height="22" color="0xFFFFFF"/>
			    <Label text="编号" x="27" y="57" color="0xbdbdbd"/>
			    <TextInput skin="png.comp.textinput" x="202" y="56" margin="2" var="txt_name" width="80" height="22" color="0xFFFFFF"/>
			    <Label text="名称" x="168" y="57" color="0xbdbdbd"/>
			    <TextInput skin="png.comp.textinput" x="61" y="92" margin="2" width="80" height="22" var="txt_x" text="285" color="0xFFFFFF"/>
			    <Label text="中心X" x="20" y="93.5" color="0xbdbdbd"/>
			    <TextInput skin="png.comp.textinput" x="202" y="92" margin="2" width="80" height="22" var="txt_y" text="269" color="0xFFFFFF"/>
			    <Label text="中心Y" x="161" y="93.5" color="0xbdbdbd"/>
			    <ComboBox labels="1,3,5,8" skin="png.comp.combobox" x="61" y="125" selectedIndex="2" labelMargin="10" width="80" sizeGrid="10,0,20,0" var="cb_dirCount" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			    <Label text="方向" x="27" y="126.5" width="28" height="19" color="0xbdbdbd"/>
			    <Label text="属性" x="12" color="0xe0e0e0"/>
			    <ComboBox labels="label1,label2" skin="png.comp.combobox" x="59" var="com_moudle" y="22" sizeGrid="20,0,20,0" width="82" height="22" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			    <Label text="模板" x="27" y="23.5" color="0xbdbdbd"/>
			    <Button skin="png.comp.btn_12" x="145" y="57" stateNum="1" toolTip="对换" var="btn_change"/>
			    <Box x="166" y="19" var="box_effect_model">
			      <Label text="动作" y="1" color="0xbdbdbd"/>
			      <ComboBox skin="png.comp.combobox" x="36" y="0" selectedIndex="0" width="80" height="22" sizeGrid="10,0,20,0" var="cb_effect_action" visible="true" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			    </Box>
			    <CheckBox label="素材允许旋转" skin="png.comp.check_dark" x="180" y="127" selected="true" var="check_rotaion" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			  </Box>
			  <Box x="11" y="36">
			    <Image skin="png.comp.img_container" y="10" sizeGrid="40,5,5,5" width="370" height="53" x="0"/>
			    <TextInput skin="png.comp.textinput" x="61" y="26" margin="2" var="txt_path" width="200" height="22" color="0xFFFFFF"/>
			    <Label text="资源" x="27" y="27" color="0xbdbdbd"/>
			    <CheckBox label="批量" skin="png.comp.checkbox" x="264" y="28" var="cb_batch" labelColors="0xe0e0e0,0xFFFFFF,0xFFFFFF"/>
			    <Label text="目标" x="12" color="0xe0e0e0"/>
			    <Button label="浏览" skin="png.comp.btn_small_secondary" x="313" y="22" var="btn_browse" sizeGrid="19,0,19,0" width="50" height="30" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  </Box>
			</Dialog>;
		public function DialogAddCompResUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}