package view.window 
{
	import editor.EditorManager;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import game.data.DataManager;
	import game.data.events.AttributeEvent;
	import editor.manager.CatalogManager;
	import editor.manager.LibraryManager;
	import morn.core.components.*;
	import morn.core.handlers.Handler;
	import view.auto.window.WindowActionUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ActionProperty extends WindowActionUI 
	{
		private static var FRAME_CHANGE:String = "frame_change";
		private var _currObj:Object = null;
		private var _currResNode:XML = null;
		private var _displayModel:Array = [];
		public function ActionProperty() 
		{
			super();
			list_frame.renderHandler = new Handler(handlerRender);
			this.addEventListener(FRAME_CHANGE, handlerFrameChange);
			btn_action.clickHandler = new Handler(save);
			tab_displayModel.selectHandler=new Handler(handlerTabSelected);
		}
		private function handlerTabSelected(index:int):void 
		{
			var obj:Object = _displayModel[index];
			if (obj) 
			{
				var resNode:XML = DataManager.library.getResNode(obj.id, obj.catalog);
				_currObj = obj;
				_currResNode = resNode;
				setData(resNode, obj);
			}
		}
		public function save():void 
		{
			if (!_currResNode) return;
			//TODO 更改xml节点
			_currResNode.@center = txt_centerX.text + "," + txt_centerY.text;
			_currResNode.@dir = txt_dir.text;
			DataManager.library.addResNode(_currResNode);
			DataManager.library.createBinFileByXmlNode(_currResNode, _currObj.action);
			App.log.info("bin文件修改成功")
			//TODO 如果更改catalog，则执行moveTo的操作
			//TODO 重新生成bin文件
			//TODO 重新显示当前资源
		}
		private function handlerFrameChange(e:Event):void 
		{
			var target:TextField = e.target as TextField;
			var index:int = int(target.name.replace("txt_",""));
			var framecount:int = 0;
			list_frame.array[index] = int(target.text)<=0?1:int(target.text);
			var frameinfo:String = list_frame.array.join(",");
			var count:int = 0;
			for (var i:int = 0; i < list_frame.array.length; i++)
			{
				count += int(list_frame.array[i]);
			}
			var xmlList:XMLList = _currResNode.children();
			if (!xmlList || !xmlList[0]) 
			{
				_currResNode.@framecount = count;
				_currResNode.@frameinfo = frameinfo;
			}else{
				for (i = 0; i < xmlList.length(); i++) 
				{
					var child:XML = xmlList[i] as XML;
					if (String(child.@id)==_currObj.action)
					{
						child.@framecount = count;
						child.@frameinfo = frameinfo;
					}
				}
			}
			list_frame.refresh();
		}
		public function showProperty(obj:Object):void
		{
			var resNode:XML = DataManager.library.getResNode(obj.id, obj.catalog);
			if (resNode) 
			{
				var displayModel:int = CatalogManager.instance.getDisplayIdByCatalogId(int(resNode.@catalog));
				_displayModel[displayModel] = obj;
				
				_currObj = obj;
				_currResNode = resNode;
				setData(resNode, obj);
			}else{
				trace("不存在资源:",obj.id,obj.name);
			}
		}
		private function setData(resNode:XML,obj:Object):void 
		{
			var actionnNode:XML = null;
			var xmlList:XMLList = resNode.children();
			var pointStr:String = resNode.@center;
			for each(var xml:XML in xmlList) 
			{
				if (String(xml.@id)==obj.action) 
				{
					var tempCenter:String = xml.@center;
					if (tempCenter && tempCenter!="") 
					{
						pointStr = tempCenter;
						break;
					}
					break;
				}
			}
			var point:Array = pointStr.split(",");
			txt_name.text = resNode.@name;
			txt_dir.text = resNode.@dir;
			txt_path.text = CatalogManager.instance.getAbsolutePath(obj.catalog);
			
			txt_centerX.text = point[0];
			txt_centerY.text = point[1];
			
			txt_renderTicket.text = 25+"";
			
			for (var i:int = 0; i < xmlList.length(); i++) 
			{
				var child:XML = xmlList[i] as XML;
				if (String(child.@id)==obj.action)
				{
					actionnNode = child;
					txt_frameCount.text = child.@framecount;
				}
			}
			txt_playTime.text = ((1 / 25) * int(txt_frameCount.text)) + "";
			if (obj.catalog>=10) 
			{
				actionnNode = resNode;
			}
			if (actionnNode) 
			{
				var frameInfoStr:String = actionnNode.@frameinfo;
				list_frame.array=frameInfoStr.split(",");
			}
		}
		private function handlerRender(item:Box,index:int):void 
		{
			if (list_frame.array[index]) 
			{
				var txt_imgid:Label = item.getChildByName("txt_id") as Label;
				var txt_frame:TextInput = item.getChildByName("txt_frame") as TextInput;
				//
				txt_imgid.text = "图 片 [" + (index + 1) + "]";
				txt_frame.text = list_frame.array[index];
				txt_frame.textField.name = "txt_" + index;
				txt_frame.textField.addEventListener(Event.CHANGE, InputTextChange);
				function InputTextChange(e:Event):void 
				{
					var target:TextField = e.target as TextField;
					target.dispatchEvent(new Event(FRAME_CHANGE,true));
				}
			}
		}
	}

}