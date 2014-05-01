package views.common
{
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * 分数视图 
	 * @author haojie.wang
	 * 
	 */
	public class Score extends Sprite
	{
		private var _mcs:Vector.<MovieClip>;
		private var _ts:Vector.<Texture>;
		public function Score(ts:Vector.<Texture>)
		{
			super();
			_ts = ts;
			_mcs = new Vector.<MovieClip>();
			setValue(0);
		}
		
		/**
		 * 设置分数值 
		 * @param value
		 * 
		 */
		public function setValue(value:int):void
		{
			var strs:Array = value.toString().split("");
			while(_mcs.length < strs.length)
			{
				var mc:MovieClip = new MovieClip(_ts,1);
				mc.pause();
				if(0 == _mcs.length)
				{
					mc.x = 0;
				}
				else
				{
					mc.x = _mcs[_mcs.length - 1].x - mc.width;
				}
				_mcs.push(mc);
				this.addChild(mc);
			}
			
			strs = strs.reverse();
			var count:int = _mcs.length;
			while(--count > -1)
			{
				_mcs[count].currentFrame = int(strs[count]);
			}
		}
	}
}