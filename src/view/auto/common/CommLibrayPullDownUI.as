/**Created by the Morn,do not modify.*/
package view.auto.common {
	import morn.core.components.*;
	public class CommLibrayPullDownUI extends View {
		public var box_title:Box = null;
		public var txt_title:Label = null;
		public var clip_arrow:Clip = null;
		public var btn_show:Button = null;
		public var btn_hide:Button = null;
		public var treeLibrary:List = null;
		protected static var uiXML:XML =
			<View width="200" height="300" x="0">
			  <Box var="box_title" left="0" right="0">
			    <Image skin="png.comp.img_title" y="49" left="0" right="0" top="0" sizeGrid="1,1,1,1"/>
			    <Label text="title" top="2" var="txt_title" height="18" width="81" x="87" color="0xe0e0e0" y="2"/>
			    <Clip skin="png.comp.clip_tree_arrow" y="149" var="clip_arrow" clipX="1" clipY="2" index="1" top="5" left="1" x="83"/>
			    <Button skin="png.comp.btn_加号" y="82" stateNum="1" var="btn_show" visible="false" width="185" height="22" alpha="0" x="356" left="0" right="0" top="0"/>
			    <Button skin="png.comp.btn_加号" stateNum="1" var="btn_hide" height="22" alpha="0" x="384" width="50" left="0" right="0" top="0"/>
			  </Box>
			  <List x="1" var="treeLibrary" top="22" left="0" right="0" vScrollBarSkin="png.comp.vscroll">
			    <Box name="render" width="225" height="21" left="0" right="0">
			      <Clip skin="png.comp.clip_select" clipX="1" clipY="2" sizeGrid="2,2,2,2" width="225" height="21" name="selectBox" x="0" y="0" left="0" right="0"/>
			      <Label text="label" x="20" y="0.5" name="txt_name" color="0xe0e0e0" isHtml="true"/>
			      <Clip skin="png.comp.clip_tree_folder" x="1" y="2" clipX="1" clipY="3" name="folder" width="16" height="16"/>
			    </Box>
			  </List>
			</View>;
		public function CommLibrayPullDownUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}