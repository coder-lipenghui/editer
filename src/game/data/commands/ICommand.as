package game.data.commands 
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