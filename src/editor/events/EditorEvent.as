package editor.events 
{
	import flash.events.Event;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class EditorEvent extends Event 
	{
		public static var PROJECT_FILE_LOADED:String="project_file_loaded";
		public static var FOCUS_IN:String = "FOCUS_IN";
		public static var LOG_REFRESH:String = "log_refresh";
		public static var CONTEXT_DELETE:String = "context_delete";
		public static var CONTEXT_SHOW:String = "context_show";
		public static var CONTEXT_COPY:String = "context_copy";
		public static var CONTEXT_PASTE:String = "context_paste";
		
		public static var CONTEXT_RENAME:String = "context_rename";
		public static var CONTEXT_ADD_FILE:String = "context_add_file";
		public static var CONTEXT_ADD_FOLDER:String = "context_add_folder";
		public static var CONTEXT_MAP_EDIT:String = "context_map_edit";
		public static var CONTEXT_MAP_EXPORT:String = "context_map_export";
		public static var CONTEXT_RES_EXPORT:String = "context_res_export";
		public static var CONTEXT_RES_DELETE:String = "contexzt_res_delete";
		
		public static var CONTEXT_RES_EDIT:String = "context_res_edit";
		public static var CONTEXT_EFFECT_EDIT:String = "context_effect_edit";
		
		public static var DATA_REFRESH:String = "data_refresh";
		
		public static var ATTRIBUTE_ACTION:String = "attribute_action";
		
		public static var ADD_ONE_MONGEN:String = "ADD_ONE_MONGEN";
		
		public static var LIBRARY_LOAD_COMPLETED:String = "library_load_completed";
		public static var ACTION_LOAD_COMPLETED:String = "action_load_completed";
		public static var LIBRARY_BINFILE_COMPLETED:String = "library_binfile_completed";
		
		private var _data:*= null;
		private var _callBack:*= null;
		public function EditorEvent(type:String,data:*=null,callBack:Handler=null,bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_data = data;
			_callBack = callBack;
			super(type, bubbles, cancelable);
		}
		override public function clone():flash.events.Event
		{
			return new EditorEvent(type,_data,_callBack,bubbles, cancelable);
		}
		
		public function get data():* 
		{
			return _data;
		}
		
		public function set data(value:*):void 
		{
			_data = value;
		}
		
		public function get callBack():* 
		{
			return _callBack;
		}
		
		public function set callBack(value:*):void 
		{
			_callBack = value;
		}
	}

}