/**Created by the Morn,do not modify.*/
package view.auto.common {
	import morn.core.components.*;
	public class CommSearchViewUI extends View {
		public var list_item:List = null;
		public var btn_del:Button = null;
		public var txt_input:TextInput = null;
		public var btn_add:Button = null;
		protected static var uiXML:XML =
			<View width="200" height="340">
			  <List x="0" y="25" vScrollBarSkin="png.comp.vscroll" width="200" height="308" repeatY="11" spaceY="2" var="list_item">
			    <Box name="render" x="0" y="0" width="182" height="24">
			      <Clip skin="png.comp.clip_selectBox" name="selectBox" clipX="1" clipY="2" left="0" right="0" top="0" bottom="0" x="10" y="10"/>
			      <TextInput skin="png.comp.textinput" width="159" height="22" name="txt_input" x="1" y="1" color="0xFFFFFF" margin="2,2"/>
			      <Button skin="png.comp.btn_delete_w" x="161" y="0" stateNum="1" var="btn_del"/>
			    </Box>
			  </List>
			  <TextInput skin="png.comp.textinput" x="0" y="0" width="138" height="22" var="txt_input" color="0xFFFFFF" margin="2,2"/>
			  <Button label="添加" skin="png.comp.button" x="140" y="0" var="btn_add" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			</View>;
		public function CommSearchViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}