package game.assets.animat 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class AnimatInfo
	{
		/**Plist文件的名字*/
		public var fileName:String = "";
		/***/
		public var name:String = "";
		public var x:uint=0;
		public var y:uint=0;
		public var w:uint=0;
		public var h:uint=0;
		public var rotated:int=1;
		public var offset:Point=null;
		
		public var oldX:int = 0;
		public var oldY:int = 0;
		public var sourceW:int = 0;
		public var sourceH:int = 0;
		public var offestX:int = 0;
		public var offestY:int = 0;
		
		public function AnimatInfo() 
		{
			
		}
		
	}

}