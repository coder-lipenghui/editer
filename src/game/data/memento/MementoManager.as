package game.data.memento 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class MementoManager 
	{
		private static var _mapHistory:Array = [];
		private static var _length:int = 0;
		private static var _currIndex:int = 0;
		public function MementoManager() 
		{
			
		}
		public static function getState(index:int):Dictionary
		{
			return _mapHistory[index];
		}
		public static function add(state:Dictionary):void
		{
			_mapHistory.push(state);
		}
		public static function remove(index:int):Dictionary 
		{
			return _mapHistory.removeAt(index);
		}
		public static function pop():Dictionary 
		{
			return _mapHistory.pop();
		}
		public static function clean():void
		{
			_mapHistory = [];
		}
		
		static public function get length():int 
		{
			return _mapHistory.length;
		}
	}

}