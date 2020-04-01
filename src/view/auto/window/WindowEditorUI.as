/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	import view.window.CodeEdit;
	import view.window.MapEdit;
	import view.window.ResEdit;
	public class WindowEditorUI extends View {
		public var tab_edit:Tab = null;
		public var vs_edit:ViewStack = null;
		public var uv_mapEditer:MapEdit = null;
		public var uv_resEditer:ResEdit = null;
		public var uv_code:CodeEdit = null;
		protected static var uiXML:XML =
			<View width="842" height="583">
			  <Image skin="png.comp.img_bg" left="0" right="0" top="0" bottom="0" sizeGrid="10,22,10,10" x="228" y="706"/>
			  <Image skin="png.comp.bg" sizeGrid="2,2,2,2" left="0" right="0" top="19" bottom="0"/>
			  <Tab labels="地图编辑,资源编辑,文本编辑" skin="png.comp.tab" labelColors="0xe0e0e0,0xe0e0e0,0xe0e0e0" left="0" top="0" var="tab_edit" selectedIndex="0"/>
			  <Image skin="png.comp.img_blackBg" x="138" y="186" left="0" right="0" top="20" bottom="0"/>
			  <ViewStack left="0" right="0" top="20" bottom="0" x="273" y="316" var="vs_edit">
			    <WindowMapEdit y="0" name="item0" runtime="view.window.MapEdit" x="0" left="0" right="0" top="0" bottom="0" var="uv_mapEditer"/>
			    <WindowResEdit x="0" name="item1" y="0" left="0" right="0" top="0" bottom="0" runtime="view.window.ResEdit" var="uv_resEditer"/>
			    <WindowTextEdit x="0" y="0" var="uv_code" name="item2" left="0" right="0" top="0" bottom="0" runtime="view.window.CodeEdit"/>
			  </ViewStack>
			</View>;
		public function WindowEditorUI(){}
		override protected function createChildren():void {
			viewClassMap["view.window.CodeEdit"] = CodeEdit;
			viewClassMap["view.window.MapEdit"] = MapEdit;
			viewClassMap["view.window.ResEdit"] = ResEdit;
			super.createChildren();
			createView(uiXML);
		}
	}
}