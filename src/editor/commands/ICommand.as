package editor.commands 
{
	/**
	 * ...
	 * @author ...
	 */
	public interface ICommand 
	{
		function execute():void;
		function undo():void;
	}
}