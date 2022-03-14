/**Created by the Morn,do not modify.*/
package view.auto {
	import morn.core.components.*;
	import view.window.ActionProperty;
	import view.window.BaseData;
	import view.window.Library;
	import view.window.Log;
	import view.window.Project;
	import view.window.Property;
	import view.window.WorkEditor;
	public class MainWorkUI extends View {
		public var uv_baseData:BaseData = null;
		public var uv_property:Property = null;
		public var uv_log:Log = null;
		public var uv_editor:WorkEditor = null;
		public var btn_addEffect:Button = null;
		public var uv_library:Library = null;
		public var uv_action:ActionProperty = null;
		public var btn_project:Button = null;
		public var uv_project:Project = null;
		public var btn_export:Button = null;
		public var box_action:Box = null;
		public var btn_exportCloth:Button = null;
		public var btn_exportWeapon:Button = null;
		public var btn_exportWing:Button = null;
		public var btn_exportEffect:Button = null;
		public var btn_exportQiege:Button = null;
		public var btn_exportMount:Button = null;
		public var btn_exportPet:Button = null;
		public var btn_crack:Button = null;
		public var box_crack:Box = null;
		public var btn_crackBin:Button = null;
		public var btn_group:Button = null;
		public var btn_convert:Button = null;
		public var btn_legend:Button = null;
		public var box_project:Box = null;
		public var btn_create:Button = null;
		public var btn_open:Button = null;
		public var btn_last:Button = null;
		public var btn_file:Button = null;
		public var box_file:Box = null;
		public var btn_addComRes:Button = null;
		public var btn_addMap:Button = null;
		public var btn_addConfig:Button = null;
		public var btn_setting:Button = null;
		protected static var uiXML:XML =
			<View width="1280" height="760">
			  <Image skin="png.comp.bg" left="0" right="0" top="0" bottom="0" x="-62" y="-9" sizeGrid="2,2,2,2,1"/>
			  <WindowProject width="230" left="231" var="uv_baseData" runtime="view.window.BaseData" height="380" top="25"/>
			  <WindowProperty x="377" y="57" right="2" top="25" bottom="0" runtime="view.window.Property" var="uv_property"/>
			  <WindowLog x="213" y="608" bottom="0" left="461" right="204" runtime="view.window.Log" var="uv_log"/>
			  <WindowEditor x="238" y="35" left="461" right="204" top="25" bottom="152" runtime="view.window.WorkEditor" var="uv_editor"/>
			  <Button label="新增特效" skin="png.comp.button" x="1155" y="2" var="btn_addEffect" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <WindowLibrary y="-35" height="200" left="1" runtime="view.window.Library" var="uv_library" x="-131" top="25" bottom="0"/>
			  <WindowAction x="565" y="101" right="2" top="25" bottom="0" var="uv_action" runtime="view.window.ActionProperty"/>
			  <Button label="项目" skin="png.comp.button" x="2" y="2" var="btn_project" labelColors="0xbdbdbd,0xffffff,0xe0e0e0"/>
			  <Button label="文件" skin="png.comp.button" x="718" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="视图" skin="png.comp.button" x="780" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="操作" skin="png.comp.button" x="842" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="图层" skin="png.comp.button" x="904" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="发布" skin="png.comp.button" x="966" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="插件" skin="png.comp.button" x="1028" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="帮助" skin="png.comp.button" x="1090" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <WindowProject x="442" y="572" bottom="2" var="uv_project" runtime="view.window.Project" left="231" height="380"/>
			  <Button label="导 出" skin="png.comp.button" x="124" y="2" var="btn_export" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Box x="124" y="25" visible="false" var="box_action">
			    <Button label="外  观" skin="png.comp.button" var="btn_exportCloth" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			    <Button label="武  器" skin="png.comp.button" y="24" var="btn_exportWeapon" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			    <Button label="翅  膀" skin="png.comp.button" var="btn_exportWing" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true" y="48"/>
			    <Button label="特  效" skin="png.comp.button" y="72" var="btn_exportEffect" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			    <Button label="切  割" skin="png.comp.button" y="96" var="btn_exportQiege" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			    <Button label="坐  骑" skin="png.comp.button" y="120" var="btn_exportMount" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			    <Button label="宠  物" skin="png.comp.button" y="144" var="btn_exportPet" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  </Box>
			  <Button label="资源整理" skin="png.comp.button" x="185" y="2" var="btn_crack" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Box x="185" y="25" var="box_crack" visible="false">
			    <Button label="游戏B" skin="png.comp.button" y="23" var="btn_crackBin" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true" x="0"/>
			    <Button label="游戏A" skin="png.comp.button" var="btn_group" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true" y="0"/>
			    <Button label="8转5" skin="png.comp.button" y="46" var="btn_convert" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true" x="0"/>
			    <Button label="私服资源" skin="png.comp.button" y="69" var="btn_legend" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true" x="0"/>
			  </Box>
			  <Box x="2" y="25" var="box_project" visible="false">
			    <Button label="新建" skin="png.comp.button" y="23" var="btn_create" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true" x="0"/>
			    <Button label="打开" skin="png.comp.button" var="btn_open" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true" y="0"/>
			    <Button label="最近" skin="png.comp.button" y="46" var="btn_last" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true" x="0"/>
			  </Box>
			  <Button label="文 件" skin="png.comp.button" x="63" y="2" var="btn_file" labelColors="0xbdbdbd,0xffffff,0xe0e0e0"/>
			  <Box x="63" y="25" var="box_file" visible="false">
			    <Button label="新增资源" skin="png.comp.button" var="btn_addComRes" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			    <Button label="新增地图" skin="png.comp.button" y="23" var="btn_addMap" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			    <Button label="新增配置" skin="png.comp.button" y="46" var="btn_addConfig" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  </Box>
			  <Button label="设 置" skin="png.comp.button" x="246" y="2" var="btn_setting" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			</View>;
		public function MainWorkUI(){}
		override protected function createChildren():void {
			viewClassMap["view.window.ActionProperty"] = ActionProperty;
			viewClassMap["view.window.BaseData"] = BaseData;
			viewClassMap["view.window.Library"] = Library;
			viewClassMap["view.window.Log"] = Log;
			viewClassMap["view.window.Project"] = Project;
			viewClassMap["view.window.Property"] = Property;
			viewClassMap["view.window.WorkEditor"] = WorkEditor;
			super.createChildren();
			createView(uiXML);
		}
	}
}