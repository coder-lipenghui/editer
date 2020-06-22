/**Created by the Morn,do not modify.*/
package view.auto.common {
	import morn.core.components.*;
	public class CommResPreviewUI extends View {
		public var img_bg:Image = null;
		public var btn_turn_left:Button = null;
		public var btn_turn_right:Button = null;
		public var box_play:Box = null;
		public var btn_playRepeat:Button = null;
		public var btn_playOnce:Button = null;
		public var img_h:Image = null;
		public var img_v:Image = null;
		public var img_pos:Image = null;
		public var txt_name:Label = null;
		public var list_displayModel:List = null;
		public var btn_trigger:Button = null;
		protected static var uiXML:XML =
			<View width="300" height="420">
			  <Clip skin="png.comp.clip_select" x="-594" y="83" name="selectBox" clipX="1" clipY="2" left="0" right="0" top="0" bottom="0"/>
			  <Image skin="png.comp.bg" left="0" right="0" top="0" bottom="0" sizeGrid="2,2,2,2" var="img_bg" visible="true" alpha="0.8" x="10" y="10"/>
			  <Button skin="png.comp.btn_left" stateNum="1" left="0" x="0" y="260" var="btn_turn_left" visible="false" bottom="0"/>
			  <Button skin="png.comp.btn_right" stateNum="1" right="0" x="200" y="260" var="btn_turn_right" visible="false" bottom="0"/>
			  <Box centerX="0" bottom="5" mouseEnabled="false" x="10" y="10" var="box_play" visible="false">
			    <Button skin="png.comp.btn_playCircle" x="69" scale="0.85" var="btn_playRepeat" stateNum="1"/>
			    <Button skin="png.comp.btn_playCircleFill" scale="0.85" var="btn_playOnce" stateNum="1"/>
			  </Box>
			  <Image skin="png.comp.hongxian" x="20" left="0" right="0" bottom="100" alpha="0.4" y="20" var="img_h"/>
			  <Image skin="png.comp.hongxianV" x="165" y="94" top="0" bottom="0" centerX="0" alpha="0.4" var="img_v"/>
			  <Image skin="png.comp.shadow" var="img_pos" y="296" centerX="0" x="98"/>
			  <Label text="动作" var="txt_name" x="107" y="232" centerX="0" bottom="50" color="0xFFFFFF"/>
			  <List y="40" var="list_displayModel" width="63" height="246" spaceX="1" left="0" top="20" visible="false" x="-287">
			    <Box name="render" x="0" y="-1">
			      <Image skin="png.comp.blank" width="60" height="22"/>
			      <Clip skin="png.comp.clip_select" clipX="1" clipY="2" sizeGrid="2,2,2,2,1" clipWidth="60" clipHeight="22" width="60" height="22" name="selectBox"/>
			      <Label text="label" x="14" y="1" name="txt_displayModelName" color="0xFFFFFF"/>
			    </Box>
			  </List>
			  <Button skin="png.comp.btn_action" x="-85" y="37" stateNum="3" left="0" top="0" var="btn_trigger"/>
			</View>;
		public function CommResPreviewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}