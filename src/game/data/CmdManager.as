package game.data {
	import game.data.commands.CommandBase;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class CmdManager 
	{
		private static var _instance:CmdManager = null;
		private var _mapCmdList:Dictionary = new Dictionary;
		public function CmdManager() 
		{
			if (_instance) 
			{
				return;
			}
			_instance = this;
		}
		public function createCmdListByMapId(id:String):void 
		{
			if (!_mapCmdList[id]) 
			{
				_mapCmdList[id] = [];
			}
		}
		/**
		 * 增加且执行一条命令
		 */
		public function addCmdAndExecute(id:String,cmd:CommandBase):void
		{
			createCmdListByMapId(id);
			_mapCmdList[id].push(cmd);
			cmd.execute();
		}
		/**
		 * 删除一条命令,并且执行撤销(ctrl+z)
		 */
		public function remCmdAndUndo(id:String):void 
		{
			if (_mapCmdList[id] && (_mapCmdList[id] as Array).length>0) 
			{
				var cmd:CommandBase = (_mapCmdList[id]as Array).pop();
				cmd.undo();
			}
		}
		
		static public function get instance():CmdManager 
		{
			if (!_instance) 
			{
				_instance = new CmdManager();
			}
			return _instance;
		}
	}

}