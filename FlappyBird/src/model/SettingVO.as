package model
{
	/**
	 * VO设置 
	 * @author haojie.wang
	 * @date 2014-4-19
	 */
	public class SettingVO
	{
		/**
		 * 飞行速度 
		 */		
		public var flySpeed:int = 4;
				
		/**
		 * 地心引力 
		 */		
		public var gravitation:Number = 0.98;
		
		/**
		 * 向上飞行的力量 
		 */		
		public var flyPower:Number = 0.2;
		
		/**
		 * 水管水平间隙 
		 */		
		public var pipeGapX:int = 200;
		
		/**
		 * 水管垂直间隙 
		 */		
		public var pipeGapY:int = 98;
		
		/**
		 * 水管最小高度 
		 */		
		public var minPipePos:int = 80;
		
		/**
		 * 水管最大高度 
		 */		
		public var maxPipePos:int = 250;
		
		/**
		 * 自由飞行速度 
		 */		
		public var freeFlySpeed:Number = 0.5;
	}
}