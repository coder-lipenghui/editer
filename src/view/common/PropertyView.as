package view.common 
{
	import editor.configuration.BaseAttribute;
	import morn.core.components.VBox;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class PropertyView extends VBox 
	{
		public var _ba:BaseAttribute = null;
		public function PropertyView(ba:BaseAttribute = null) 
		{
			super();
			_ba = ba;
			build();
		}
		private function build():void 
		{
			var keys:Array = [];
			for (var key:String in _ba.displayGroup){
				keys.push(key);
			}
			keys.sort();
			for (var i:int = 0; i < keys.length; i++) 
			{
				var pdp:PulldownPanel = new PulldownPanel();
				pdp.txt_title.text = String(keys[i]).replace(new RegExp('[0-9]','g'),"");
				pdp.attributes = _ba.displayGroup[keys[i]];
				pdp.value = _ba;
				pdp.x = 1;
				this.addChild(pdp);
			}
		}
	}

}