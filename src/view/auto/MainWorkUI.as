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
		public var btn_addComRes:Button = null;
		public var btn_addMap:Button = null;
		public var btn_addEffect:Button = null;
		public var uv_library:Library = null;
		public var btn_crackBin:Button = null;
		public var uv_action:ActionProperty = null;
		public var btn_project:Button = null;
		public var btn_exportCloth:Button = null;
		public var btn_exportWeapon:Button = null;
		public var btn_exportWing:Button = null;
		public var btn_exportEffect:Button = null;
		public var btn_group:Button = null;
		public var uv_project:Project = null;
		public var btn_exportQiege:Button = null;
		public var btn_exportMount:Button = null;
		public var btn_exportPet:Button = null;
		protected static var uiXML:XML =
			<View width="1280" height="760">
			  <Image skin="png.comp.bg" left="0" right="0" top="0" bottom="0" x="-62" y="-9" sizeGrid="2,2,2,2,1"/>
			  <WindowProject width="230" left="231" var="uv_baseData" runtime="view.window.BaseData" height="380" top="25"/>
			  <WindowProperty x="377" y="57" right="2" top="25" bottom="0" runtime="view.window.Property" var="uv_property"/>
			  <WindowLog x="213" y="608" bottom="0" left="461" right="204" runtime="view.window.Log" var="uv_log"/>
			  <WindowEditor x="238" y="35" left="461" right="204" top="25" bottom="152" runtime="view.window.WorkEditor" var="uv_editor"/>
			  <Button label="新增外观" skin="png.comp.button" x="66" y="2" var="btn_addComRes" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Button label="新增地图" skin="png.comp.button" x="130" y="2" var="btn_addMap" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Button label="新增特效" skin="png.comp.button" x="1155" y="2" var="btn_addEffect" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <WindowLibrary y="-35" height="200" left="1" runtime="view.window.Library" var="uv_library" x="-131" top="25" bottom="0"/>
			  <Button label="资源拆分" skin="png.comp.button" x="1215" y="2" var="btn_crackBin" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <WindowAction x="565" y="101" right="2" top="25" bottom="0" var="uv_action" runtime="view.window.ActionProperty"/>
			  <Button label="项目" skin="png.comp.button" x="2" y="2" var="btn_project" labelColors="0xbdbdbd,0xffffff,0xe0e0e0"/>
			  <Button label="文件" skin="png.comp.button" x="718" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="视图" skin="png.comp.button" x="780" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="操作" skin="png.comp.button" x="842" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="图层" skin="png.comp.button" x="904" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="发布" skin="png.comp.button" x="966" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="插件" skin="png.comp.button" x="1028" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="帮助" skin="png.comp.button" x="1090" y="2" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="false"/>
			  <Button label="发布外观" skin="png.comp.button" x="194" y="2" var="btn_exportCloth" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Button label="发布武器" skin="png.comp.button" x="258" y="2" var="btn_exportWeapon" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Button label="发布翅膀" skin="png.comp.button" x="322" y="2" var="btn_exportWing" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Button label="发布特效" skin="png.comp.button" x="386" y="2" var="btn_exportEffect" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Button label="资源整理" skin="png.comp.button" x="642" y="2" var="btn_group" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <WindowProject x="442" y="572" bottom="2" var="uv_project" runtime="view.window.Project" left="231" height="380"/>
			  <Button label="发布切割" skin="png.comp.button" x="450" y="2" var="btn_exportQiege" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Button label="发布坐骑" skin="png.comp.button" x="514" y="2" var="btn_exportMount" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
			  <Button label="发布宠物" skin="png.comp.button" x="578" y="2" var="btn_exportPet" labelColors="0xbdbdbd,0xffffff,0xe0e0e0" visible="true"/>
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