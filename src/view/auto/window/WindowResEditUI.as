/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	import view.common.ResPreview;
	public class WindowResEditUI extends View {
		public var img_mask:Image = null;
		public var list_preview:List = null;
		public var tab_action:Tab = null;
		public var btn_turn_left:Button = null;
		public var btn_turn_right:Button = null;
		public var btn_playOnce:Button = null;
		public var btn_playRepeat:Button = null;
		public var cb_model:ComboBox = null;
		public var btn_unselected:Button = null;
		protected static var uiXML:XML =
			<View width="842" height="583">
			  <Image skin="png.comp.blank" var="img_mask" left="0" right="0" top="0" bottom="0"/>
			  <RadioGroup labels="白底,黑底" skin="png.comp.radiogroup" right="1" top="1" labelColors="0xe1e1e1,0xe1e1e1,0xe1e1e1"/>
			  <List top="22" bottom="45" var="list_preview" spaceX="2" spaceY="2" right="0" left="0" mouseEnabled="false" vScrollBarSkin="png.comp.vscroll">
			    <CommResPreview runtime="view.common.ResPreview" mouseEnabled="false" x="0" y="0" name="render"/>
			  </List>
			  <Tab skin="png.comp.tab" x="1" y="1" direction="horizontal" var="tab_action" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			  <Box x="171" y="330" centerX="0" bottom="5">
			    <Button skin="png.comp.btn_left" stateNum="1" var="btn_turn_left"/>
			    <Button skin="png.comp.btn_right" x="183" var="btn_turn_right" stateNum="1"/>
			    <Button skin="png.comp.btn_playCircleFill" x="61" var="btn_playOnce" stateNum="1"/>
			    <Button skin="png.comp.btn_playCircle" x="122" var="btn_playRepeat" stateNum="1"/>
			  </Box>
			  <ComboBox labels="外观,武器,翅膀,坐骑" skin="png.comp.combobox" x="0" bottom="1" left="1" selectedIndex="0" var="cb_model" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF" sizeGrid="20,0,30,0"/>
			  <Button label="取消选中" skin="png.comp.button" var="btn_unselected" bottom="23" left="1" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			</View>;
		public function WindowResEditUI(){}
		override protected function createChildren():void {
			viewClassMap["view.common.ResPreview"] = ResPreview;
			super.createChildren();
			createView(uiXML);
		}
	}
}