package view.window 
{
	import editor.events.EditorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.core.handlers.Handler;
	import view.auto.window.WindowEditorUI;
	
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class WorkEditor extends WindowEditorUI 
	{
		
		public function WorkEditor() 
		{
			super();
			tab_edit.selectHandler = new Handler(handlerTabSelected);
		}
		private function handlerTabSelected(index:int):void 
		{
			vs_edit.selectedIndex = index;
		}
		override protected function resetPosition():void 
		{
			super.resetPosition();
		}
	}

}