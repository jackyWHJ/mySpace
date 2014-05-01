package model
{
	/**
	 * 游戏状态 
	 * @author haojie.wang
	 * @date 2014-4-19
	 */	
	public class GamingState
	{
		/**
		 * 游戏准备中 
		 */		
		static public const PREPARE:int = 1
		
		/**
		 * 游戏进行中 
		 */		
		static public const RUNNING:int = 2;
		
		/**
		 * 游戏暂停中 
		 */		
		static public const PAUSE:int = 3;
		
		/**
		 * 游戏结束 
		 */		
		static public const END:int = 4;
	}
}