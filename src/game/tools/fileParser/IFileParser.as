package game.tools.fileParser 
{
	
	/**
	 * ...
	 * @author lee
	 */
	public interface IFileParser 
	{
		function Read(path:String):Array;
		function Write(path:String):Boolean;
	}
}