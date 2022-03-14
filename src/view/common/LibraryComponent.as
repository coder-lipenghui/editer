package view.common 
{
	import flash.events.Event;
	import editor.manager.DataManager;
	import editor.manager.CatalogManager;
	import morn.core.components.Component;
	import morn.core.components.VBox;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LibraryComponent extends VBox 
	{
		private var list:Array = [];
		private var _selectdIndex:int = -1;
		private var _selection:LibraryPullDown = null;
		private var _currCatalogId:int =-1;
		public function LibraryComponent()
		{
			super();
			addEventListener(LibraryPullDown.LIBRARY_PULL_DOWN_HIDE, handleVisible);
			addEventListener(LibraryPullDown.LIBRARY_PULL_DOWN_SHOW, handleVisible);
			
			this.addEventListener(Event.RESIZE, handleResize);
		}
		public function doRefresh():void 
		{
			if (_selection) 
			{
				//var child:Array = CatalogManager.instance.getCatalogByParentId(_selection.catalogId);
				var catalog:*=CatalogManager.instance.getCatalogById(_selection.catalogId);
				var dic:Array = DataManager.library.getResCatalogNode(_selection.catalogId);
				_selection.setData(catalog.name,dic);
			}
		}
		public function init(catalogId:int):void 
		{
			removeAllChild();
			var catalog:Array = CatalogManager.instance.getCatalogByParentId(catalogId);
			if (!catalog || catalog.length==0) 
			{
				var dic:Array =DataManager.library.getResCatalogNode(catalogId);
				if (dic) 
				{
					var pullDown:LibraryPullDown = new LibraryPullDown(0,catalogId,0);
					pullDown.x = 0;
					pullDown.left = 0;
					pullDown.right = 0;
					pullDown.setData("", dic);
					selection = pullDown;
					this.addChild(pullDown);
				}
			}else {
				for (var i:int = 0; i < catalog.length; i++) 
				{
					var id:int = catalog[i].index;
					var child:Array = CatalogManager.instance.getCatalogByParentId(id);
					dic = DataManager.library.getResCatalogNode(id);
					pullDown = new LibraryPullDown(i, id, catalog.length);
					pullDown.x = 0;
					pullDown.left = 0;
					pullDown.right = 0;
					pullDown.setData(catalog[i].name, dic);
					this.addChild(pullDown);
					list.push(pullDown);
				}
			}
			handleResize(null);
		}
		private function handleResize(e:Event):void 
		{
			if (parent) 
			{
				this.height = stage.stageHeight / 3;
			}
		}
		private function handleVisible(e:Event):void 
		{
			for (var i:int = 0; i < list.length; i++) 
			{
				if (list[i]!=e.target) 
				{
					(list[i] as LibraryPullDown).myVisible = false;
				}else{
					_selectdIndex = i;
					selection = list[i];
				}
			}
		}
		
		public function get selectdIndex():int 
		{
			return _selectdIndex;
		}
		
		public function set selectdIndex(value:int):void 
		{
			_selectdIndex = value;
		}
		
		public function get selection():LibraryPullDown 
		{
			return _selection;
		}
		
		public function set selection(value:LibraryPullDown):void 
		{
			_selection = value;
		}
	}
}