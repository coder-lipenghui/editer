/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class WindowAssetsUI extends View {
		public var box_container:Panel = null;
		public var TreeAssets:Tree = null;
		protected static var uiXML:XML =
			<View width="230" height="200">
			  <Image skin="png.comp.img_bg" left="0" right="0" top="0" bottom="0" sizeGrid="12,23,10,12"/>
			  <Image skin="png.comp.bg" x="-579" y="44" top="18" bottom="0" left="0" right="0"/>
			  <Box bottom="3" left="3" right="0">
			    <TextInput skin="png.comp.textinput" width="191" height="22" margin="25,2" right="2" left="-1" color="0xe0e0e0"/>
			    <Image skin="png.comp.btn_search" x="0" y="-1" scale="0.8" smoothing="true" stateNum="1"/>
			  </Box>
			  <Panel top="24" bottom="26" left="2" right="2" vScrollBarSkin="png.comp.vscroll" var="box_container">
			    <Tree spaceLeft="10" spaceBottom="1" x="0" y="0" width="196" height="346" var="TreeAssets" left="1" right="1" scrollBarSkin="png.comp.vscroll" top="0" bottom="0">
			      <Box name="render" x="0" y="0" width="225" height="21">
			        <Clip skin="png.comp.clip_select" clipX="1" clipY="2" sizeGrid="2,2,2,2" width="225" height="21" name="selectBox" x="0" y="0" left="13" right="0"/>
			        <Label text="label" x="33" y="0.5" name="txt_name" color="0xe0e0e0"/>
			        <Clip skin="png.comp.clip_tree_folder" x="16" y="2" clipX="1" clipY="3" name="folder" width="16" height="16"/>
			        <Clip skin="png.comp.clip_tree_arrow" x="1" y="3" clipX="1" clipY="2" name="arrow"/>
			      </Box>
			    </Tree>
			  </Panel>
			  <Tab labels="资源" skin="png.comp.tab" selectedIndex="0" left="0" top="0" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			</View>;
		public function WindowAssetsUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}