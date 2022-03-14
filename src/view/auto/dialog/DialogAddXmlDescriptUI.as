/**Created by the Morn,do not modify.*/
package view.auto.dialog {
	import morn.core.components.*;
	public class DialogAddXmlDescriptUI extends Dialog {
		public var list_despcrition:List = null;
		public var cb_group:ComboBox = null;
		public var btn_add:Button = null;
		public var btn_select:Button = null;
		public var txt_file:TextInput = null;
		protected static var uiXML:XML =
			<Dialog width="600" height="430">
			  <Image skin="png.comp.img_dialog" left="0" right="0" top="0" bottom="0" sizeGrid="22,22,22,22" x="0" y="0" width="600" height="400"/>
			  <Image skin="png.comp.img_container" x="16" y="84" sizeGrid="40,5,5,5" width="572" height="294"/>
			  <Label text="预览" x="31" y="72" color="0xe0e0e0"/>
			  <Box x="22" y="94" width="549" height="277">
			    <Label text="KEY" x="97" color="0xbdbdbd" y="3.5"/>
			    <Label text="类型" x="237" y="3.5" color="0xbdbdbd"/>
			    <Label text="分类" x="168" y="3.5" color="0xbdbdbd"/>
			    <List x="3" y="25" vScrollBarSkin="png.comp.vscroll" spaceY="1" repeatY="10" width="548" height="252" var="list_despcrition">
			      <Box name="render" x="0" y="4">
			        <TextInput skin="png.comp.textinput" margin="2" width="73" height="22" name="txt_name" color="0xbdbdbd" x="0" y="0"/>
			        <TextInput skin="png.comp.textinput" x="279" margin="2" width="75" height="22" name="txt_default" color="0xbdbdbd"/>
			        <TextInput skin="png.comp.textinput" x="76" margin="2" width="70" height="22" name="txt_key" color="0xbdbdbd"/>
			        <ComboBox labels="必填,可选" skin="png.comp.combobox" x="149" selectedIndex="0" name="cb_type" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF" sizeGrid="20,0,30,0"/>
			        <ComboBox labels="int,string,check,array" skin="png.comp.combobox" x="214" selectedIndex="0" selectedLabel="必填,可选" name="cb_group" var="cb_group" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF" sizeGrid="20,0,30,0"/>
			        <TextInput skin="png.comp.textinput" x="436" margin="2" width="94" height="22" name="txt_tips" color="0xbdbdbd" y="0"/>
			        <TextInput skin="png.comp.textinput" x="359" margin="2" width="75" height="22" name="txt_group" color="0xbdbdbd" y="0" text="1常用"/>
			      </Box>
			    </List>
			    <Image skin="png.comp.img_splite_h" height="1" left="0" right="0" y="23"/>
			    <Label text="名称" x="20" y="3.5" color="0xbdbdbd"/>
			    <Label text="默认值" x="301" y="3.5" color="0xbdbdbd"/>
			    <Label text="备注" x="470" y="3.5" color="0xbdbdbd"/>
			    <Label text="分组" x="384" y="3" color="0xbdbdbd"/>
			  </Box>
			  <Button label="生成" skin="png.comp.btn_small_primary" x="527" y="361" var="btn_add" labelBold="false" right="10" bottom="15" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <Button label="关闭" skin="png.comp.btn_small_secondary" x="387" y="361" sizeGrid="19,0,19,0" name="close" right="80" bottom="15" labelColors="0xCDCDCD,0x2E2E2E,0xFFFFFF"/>
			  <Label text="生成配置文件描述" x="274" y="0" color="0x212121" centerX="0"/>
			  <Button label="打开" skin="png.comp.btn_small_primary" x="524" y="32" var="btn_select" labelBold="false" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0"/>
			  <TextInput skin="png.comp.textinput" x="65" y="36" width="452" height="22" var="txt_file" color="0xFFFFFF" margin="2,2"/>
			  <Label text="文件" x="31" y="37.5" color="0xe0e0e0"/>
			  <LinkButton label="说明" x="29" y="370" bottom="15" toolTip="选择需要生成配置文件的csv、txt文本。&lt;br/>文件头三行需要分别描述配置字段的：名称、字段、类型(int,string等)"/>
			</Dialog>;
		public function DialogAddXmlDescriptUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}