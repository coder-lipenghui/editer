/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.editor.core {
	import flash.display.Sprite;
	
	/**面板接口，实现了编辑器遮罩类型*/
	public interface IContent {
		function get content():Sprite;
	}
}