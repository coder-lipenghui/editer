package view.window 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import editor.manager.DataManager;
	import editor.configuration.BaseAttribute;
	import editor.configuration.XmlAttribute;
	import editor.events.EditorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import editor.tools.Logger;
	import view.auto.window.WindowDropInfoUI;
	import view.common.PropertyView;
	import view.common.XmlComponent;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class DropInfo extends WindowDropInfoUI 
	{
		private var cpv:PropertyView = null;
		public function DropInfo() 
		{
			super();
			addEventListener(MouseEvent.CLICK,function (e:Event):void 
			{
				//if (clip_focus.index==0) 
				//{
					//dispatchEvent(new EditorEvent(EditorEvent.FOCUS_IN,null,null,true));
				//}
			});
		}
		override protected function initialize():void 
		{
			super.initialize();
			box_container.vScrollBar.touchScrollEnable = false;
			//box_container.hScrollBar.touchScrollEnable = false;
		}
		public function show(ba:BaseAttribute):void 
		{
			clean();
			if (ba && ba.name=="mongen") 
			{
				var monName:String = ba.getValue("name");
				var droplist:Array = DataManager.monDropList.mon2item[monName];
				if (droplist) 
				{
					var drop:BaseAttribute = droplist[0];
					var space:int = 2;
					var yy:int = 0;
					for (var i:int = 0; i < drop.group1.length; i++) 
					{
						var xa:XmlAttribute = drop.group1[i];
						if (drop.getValue(xa.key)!=0 && xa.key!="name") 
						{
							var component:XmlComponent = new XmlComponent(xa);
							component.baseAttribute = drop;
							component.y = yy;
							box_container.addChild(component);
							yy += component.height + space;
						}
					}
				}else{
					var file:File = File.desktopDirectory.resolvePath(ProjectConfig.dataPath + "/mondrop/" + monName+".txt");
					if (file.exists) 
					{
						var dropInfoStr:String = "";
						var fs:FileStream = new FileStream();
						fs.open(file, FileMode.READ);
						dropInfoStr=fs.readMultiByte(fs.bytesAvailable, 'ANSI');
						fs.close();
						fs = null;
						txt_oldDrop.visible = true;
						txt_oldDrop.text = dropInfoStr;
						
					}
				}
			}
		}
		public function hide():void 
		{
			
		}
		private function clean():void 
		{
			box_container.removeAllChild();
		}
		override protected function resetPosition():void 
		{
			super.resetPosition();
			//if (clip_focus.index==1) 
			//{
				//showBorder(0xCFDDFA, 0.5);
			//}
		}
	}

}