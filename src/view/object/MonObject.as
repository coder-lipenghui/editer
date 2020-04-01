package view.object 
{
	import game.data.DataManager;
	import game.data.configuration.BaseAttribute;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class MonObject extends BaseObject 
	{
		private var _monName:String = "";
		private var _resId:String = "";
		public function MonObject(baseAttr:BaseAttribute,n:String="",res:String="") 
		{
			this.name = "monObject";
			this.enableDrag = true;
			_monName = baseAttr.getValue("name");
			var monBa:BaseAttribute = DataManager.monDef.getMonBaByName(_monName);
			if (monBa) 
			{
				_resId = monBa.getValue("resid");
			}
			super(baseAttr, _monName,_resId,"00",2,4);
		}
	}

}