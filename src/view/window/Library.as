package view.window 
{
	import editor.events.EditorEvent;
	import flash.events.FocusEvent;
	import morn.core.components.List;
	import view.common.LibraryComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import editor.manager.CatalogManager;;
	import morn.core.handlers.Handler;
	import view.auto.window.WindowLibraryUI;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class Library extends WindowLibraryUI 
	{
		private var _currIndex:int = 0;
		private var _catalog:Array = [];
		private var _tabIndex:Array = [];
		private var _libraryComponent:LibraryComponent = null;
		private var _firstLoad:Boolean = true;
		public function Library() 
		{
			super();
			App.stage.addEventListener(EditorEvent.LIBRARY_LOAD_COMPLETED,handleLibraryLoaded);
			addEventListener(MouseEvent.CLICK,function (e:Event):void
			{
				dispatchEvent(new EditorEvent(EditorEvent.FOCUS_IN,null,null,true));
			});
			
			btn_more.clickHandler = new Handler(function():void 
			{
				//initLibraryTree();
			});
			
			tab_catalog.labelDirection = "vertical";
			tab_catalog.selectHandler = new Handler(handlerTabSelected);
			initSearch();
		}
		private function initSearch():void 
		{
			txt_search.addEventListener(FocusEvent.FOCUS_IN,function (e:Event):void 
			{
				txt_placeholder.visible = false;
			});
			txt_search.addEventListener(FocusEvent.FOCUS_OUT,function (e:Event):void 
			{
				if (txt_search.text=="") 
				{
					txt_placeholder.visible = true;
				}
			});
			txt_search.addEventListener(Event.CHANGE, handleSearchTextChange);
		}
		private function handleSearchTextChange(e:Event):void 
		{
			var originalText:String = txt_search.text;
			var originalSearchArr:Array = originalText.split(",");
			var searchArray:Array = [];
			for (var j:int = 0; j < originalSearchArr.length; j++) 
			{
				var searchInfo:Array = originalSearchArr[j].split(":");
				var searchObj:Object = {};
				searchObj.key = searchInfo[0];
				if (searchInfo.length>=1) 
				{
					searchObj.value = searchInfo[1];
				}
				searchArray.push(searchObj);
			}
			var tempData:Array = [];
			var targetTree:List = null;
			if (_libraryComponent.selection) 
			{
				targetTree = _libraryComponent.selection.treeLibrary;
				tempData = targetTree.array;
			}
			if (!targetTree) 
			{
				trace("没有tree对象");
				return;
			}
			if (trim(originalText)=="") 
			{
				//targetTree.array = tempData;
				_libraryComponent.doRefresh();
			}else
			{
				if (!tempData) return;
				var searchResult:Array = [];
				for (var i:int = 0; i < tempData.length; i++) 
				{
					var obj:Object = tempData[i];
					for (var k:int = 0; k < searchArray.length; k++) 
					{
						var key:String = searchObj.key;
						var value:String = searchObj.value;
						if (value) 
						{
							//TODO k:v形式的查找
						}else {
							var nn:String = obj.@name;
							if (nn.indexOf(originalText)>-1)
							{
								searchResult.push(obj);
							}
						}
					}
				}
				targetTree.array = searchResult;
			}
		}
		private function trim(str:String):String{
			var _str:String=str;                
			while(_str.substr(0,1)==" "){
				_str=_str.substr(1);
			}
			while(_str.substr(-1,1)==" "){
				_str=_str.substr(0,_str.length-1);
			}
			return _str;
		}
		public function handleLibraryLoaded(e:Event):void 
		{
			initLibraryTree();
		}
		public function initLibraryTree():void
		{
			_catalog = CatalogManager.instance.getCatalogByParentId(0);
			var tabLabels:Array = [];
			for (var i:int = 0; i < _catalog.length; i++) 
			{
				tabLabels.push(_catalog[i].name);
				_tabIndex.push(_catalog[i].index);
			}
			if (_firstLoad) 
			{				
				tab_catalog.labels = tabLabels.join(",");
				tab_catalog.selectedIndex = 0;
				_firstLoad = false;
			}else{
				if (tab_catalog.labels != tabLabels.join(","))
				{
					tab_catalog.labels = tabLabels.join(",");
					tab_catalog.selectedIndex = 0;
				}
				_libraryComponent.doRefresh();
			}
		}
		
		public function getResByCatalogId(index:int):void 
		{
			createTreeList(index);
		}
		private function createTreeList(catalogid:int):void 
		{
			box.removeAllChild();
			_libraryComponent = new LibraryComponent();
			_libraryComponent.init(catalogid);
			_libraryComponent.left = 0;
			_libraryComponent.right = 0;
			_libraryComponent.top = 0;
			box.addChild(_libraryComponent);
		}
		private function handlerTabSelected(index:int):void 
		{
			getResByCatalogId(_tabIndex[index]);
		}
		override protected function resetPosition():void 
		{
			super.resetPosition();
			box.height = this.height;
		}
	}

}