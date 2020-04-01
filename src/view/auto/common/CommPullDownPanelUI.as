/**Created by the Morn,do not modify.*/
package view.auto.common {
	import morn.core.components.*;
	public class CommPullDownPanelUI extends View {
		public var box_title:Box = null;
		public var txt_title:Label = null;
		public var clip_arrow:Clip = null;
		public var btn_show:Button = null;
		public var btn_hide:Button = null;
		public var box_container:Box = null;
		protected static var uiXML:XML =
			<View width="200" height="300">
			  <Box left="0" right="0" var="box_title" top="0" x="-19" y="-269">
			    <Image skin="png.comp.img_title" x="-73" y="49" left="0" right="0" top="0" sizeGrid="1,1,1,1"/>
			    <Label text="title" top="2" var="txt_title" height="18" width="81" x="14" color="0xe0e0e0" y="2"/>
			    <Clip skin="png.comp.clip_tree_arrow" y="149" var="clip_arrow" clipX="1" clipY="2" index="1" top="5" left="1" x="10"/>
			    <Button skin="png.comp.btn_加号" y="82" stateNum="1" var="btn_show" visible="false" width="185" height="22" alpha="0" x="283" left="0" right="0" top="0"/>
			    <Button skin="png.comp.btn_加号" stateNum="1" var="btn_hide" height="22" alpha="0" x="311" width="50" left="0" right="0" top="0"/>
			  </Box>
			  <Box var="box_container" left="0" right="0" top="24" bottom="0"/>
			</View>;
		public function CommPullDownPanelUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}