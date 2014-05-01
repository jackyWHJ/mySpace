package util
{
	/**
	 * 随机数工具类 
	 * @author Administrator
	 * 
	 */
	public class RandomUtil
	{
		public function RandomUtil()
		{
		}
		/**
		 * 返回数组中的随机元素 
		 * @param array
		 * @return 
		 * 
		 */
		public static function getRandomInArray(array:Array):String
		{
			var len:int = array.length,random:int = int(Math.random()*len);
			return array[random];
		}
		/**
		 * 返回2个整数之间的随机数 
		 * @param min
		 * @param max
		 * @return 
		 * 
		 */
		public static function getIntValueBetween(min:int, max:int):int
		{
			var len:int = Math.abs(max - min),random:int = int(Math.random()*len);
			return Math.min(min,max)+random;
		}
	}
}