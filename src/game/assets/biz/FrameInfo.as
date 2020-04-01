package game.assets.biz 
{
	/**
	 * 图集的渲染播放信息
	 * @author 3464285@gmail.com
	 */
	public class FrameInfo 
	{
		public var id:int = 0;
		public var width:int = 0;
		public var height:int = 0;
		public var placeholder:int = 0;
		public var dir:int = 0;
		public var imgNum:int = 0;
		/**单方向的图集一共渲染多少次*/
		public var frameCount:int = 0;
		/**每张图渲染的次数*/
		public var keyFrameData:Array = [];
		/**按方向存放frames的信息*/
		public var frameInfo:Array = [];
		
		public function FrameInfo() 
		{
		}
		
	}

}