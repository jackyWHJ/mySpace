package control.events
{
	import starling.events.Event;
	
	/**
	 * 游戏状态事件 
	 * @author haojie.wang
	 * 
	 */
	public class StateEvent extends Event
	{
		/**
		 * 改变状态 
		 */		
		static public const CHANGE_STATE:String = "ChangeState";
		public var _data:*;
		
		public function StateEvent(type:String, data:Object=null ,bubbles:Boolean=false)
		{
			this._data = data;
			super(type, bubbles, data);
		}
	}
}