/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	
	/**Tab标签，默认selectedIndex=-1*/
	public class Tab extends Group {
		/**横向的*/
		public static const HORIZENTAL:String = "horizontal";
		/**纵向的*/
		public static const VERTICAL:String = "vertical";
		
		private var _isHtml:Boolean = false;
		private var _labelDirection:String = "horizontal";
		public function Tab(labels:String = null, skin:String = null) {
			super(labels, skin);
			_direction = HORIZENTAL;
		}
		
		override protected function createItem(skin:String, label:String):DisplayObject {
			return new Button(skin, label);
		}
		
		override protected function changeLabels():void {
			if (_items) {
				var left:Number = 0
				for (var i:int = 0, n:int = _items.length; i < n; i++) {
					var btn:Button = _items[i] as Button;
					if (_skin)
						btn.skin = _skin;
					if (_labelColors)
						btn.labelColors = _labelColors;
					if (_labelStroke)
						btn.labelStroke = _labelStroke;
					if (_labelSize)
						btn.labelSize = _labelSize;
					if (_labelBold)
						btn.labelBold = _labelBold;
					if (_labelMargin)
						btn.labelMargin = _labelMargin;
					if (_isHtml)
						btn.isHtml = _isHtml;
					if (_labelDirection) 
						btn.labelDirecation = _labelDirection;
					if (_direction == HORIZENTAL) {
						btn.y = 0;
						btn.x = left;
						left += btn.width + _space;
					} else {
						btn.x = 0;
						btn.y = left;
						left += btn.height + _space;
					}
				}
			}
		}
		
		public function get isHtml():Boolean 
		{
			return _isHtml;
		}
		
		public function set isHtml(value:Boolean):void 
		{
			_isHtml = value;
			//if (_isHtml) 
			//{
				//for (var i:int = 0; i < _items.length; i++) 
				//{
					//var btn:Button = _items[i] as Button;
					//btn.isHtml = _isHtml;
				//}
			//}
		}
		
		public function get labelDirection():String 
		{
			return _labelDirection;
		}
		
		public function set labelDirection(value:String):void 
		{
			_labelDirection = value;
		}
	}
}