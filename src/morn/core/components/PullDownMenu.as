package morn.core.components 
{
	import flash.events.Event;
	import game.library.CatalogManager;
	import morn.core.components.ComboBox;
	import morn.core.components.HBox;
	import morn.core.handlers.Handler;
	
	/**
	 * 多级联动菜单
	 * @author 3464285@gmail.com
	 */
	public class PullDownMenu extends HBox 
	{
		public static var EVENT_MENU_CHANGE:String = "event_menu_change";
		private var direction:String = "horizontal";
		private var _selectedId:int =-1;
		private var _selectedLabel:String = "";
		private var _selectedBackupPath:String = "";
		private var _selectedOutputPath:String = "";
		
		private var _selectedHandler:Handler = null;
		public function PullDownMenu() 
		{
			super();
			super.align = TOP;
			init();
		}
		public function init():void 
		{
			this.addEventListener(EVENT_MENU_CHANGE,handlerChangeMenu);
			createNode(0,null);
		}
		public function haveChildNode(id:int):Boolean 
		{
			var arr:Array = CatalogManager.instance.getCatalogByParentId(id);
			if (arr.length>0)
			{
				return true;
			}
			return false;
		}
		private function handlerChangeMenu(e:Event):void 
		{
			var cb:menu = e.target as menu;
			cb.removeAllChild();
			_selectedId = cb.selectedId;
			_selectedLabel = cb.selectedLabel;
			_selectedBackupPath = CatalogManager.instance.getAbsolutePath(_selectedId);
			_selectedOutputPath = CatalogManager.instance.getOutputPathById(_selectedId);
			createNode(cb.selectedId, cb);
			if (_selectedHandler) 
			{
				_selectedHandler.executeWith([_selectedId]);
			}
		}
		public function createNode(id:int,parent:menu):void
		{
			if (haveChildNode(id)) 
			{
				var m:menu = new menu(getCatalogLabels(id),getCatalogId(id));
				this.addChild(m);
				if (parent) 
				{
					parent.childCombox = m;
				}
			}
		}
		/**
		 * 获取子节点的名称
		 * @param	id
		 * @return x,x,x形式
		 */
		private function getCatalogLabels(id:int):String 
		{
			var nodes:Array = CatalogManager.instance.getCatalogByParentId(id);
			var labels:Array = [];
			for (var i:int = 0; i < nodes.length; i++) 
			{
				labels.push(nodes[i].name);
			}
			if (labels.length>0) 
			{
				return labels.join(",")
			}
			return "";
		}
		private function getCatalogId(id:int):Array 
		{
			var nodes:Array = CatalogManager.instance.getCatalogByParentId(id);
			var ids:Array = [];
			for (var i:int = 0; i < nodes.length; i++) 
			{
				ids.push(nodes[i].index);
			}
			return ids;
		}
		
		public function get selectedId():int 
		{
			return _selectedId;
		}
		
		public function set selectedId(value:int):void 
		{
			_selectedId = value;
		}
		/**资源备份目录*/
		public function get selectedBackupPath():String 
		{
			return _selectedBackupPath;
		}
		
		public function set selectedBackupPath(value:String):void 
		{
			_selectedBackupPath = value;
		}
		/**发布目录*/
		public function get selectedOutputPath():String 
		{
			return _selectedOutputPath;
		}
		
		public function set selectedOutputPath(value:String):void 
		{
			_selectedOutputPath = value;
		}
		
		public function get selectedHandler():Handler 
		{
			return _selectedHandler;
		}
		
		public function set selectedHandler(value:Handler):void 
		{
			_selectedHandler = value;
		}
		
		public function get selectedLabel():String 
		{
			return _selectedLabel;
		}
		
		public function set selectedLabel(value:String):void 
		{
			_selectedLabel = value;
		}
	}
}
import flash.events.Event;
import morn.core.components.ComboBox;
import morn.core.components.PullDownMenu;
import morn.core.handlers.Handler;
class menu extends ComboBox
{
	public var selectedId:int =-1;
	public var parentId:int =-1;
	public var childCombox:menu = null;
	public var parentCombox:menu = null;
	private var ids:Array = [];
	public function menu(labels:String,id:Array):void 
	{
		ids = id;
		super("png.comp.combobox", labels);
		this.selectHandler = new Handler(handlerSelected);
	}
	override protected function initialize():void 
	{
		super.sizeGrid = "20,0,20,0";
		super.itemColors = "0x999999,0xFFFFFF,0xCCCCCC,0x999999,0x333333";
		super.labelColors = "0xCCCCCC,0xFFFFFF,0xCCCCCC,0x999999";
		//super.height = 30;
		//super.width = 70;
		super.initialize();
	}
	public function removeAllChild():void 
	{
		if (childCombox) 
		{
			childCombox.removeAllChild();
			childCombox.remove();
		}
	}
	private function handlerSelected(index:int):void 
	{
		selectedId = ids[selectedIndex];
		this.dispatchEvent(new Event(PullDownMenu.EVENT_MENU_CHANGE,true));
	}
	
}