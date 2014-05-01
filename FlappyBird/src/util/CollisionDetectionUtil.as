package util
{
	import flash.geom.Rectangle;

	/**
	 * 碰撞检测工具 
	 * @author haojie.wang
	 * 
	 */
	public class CollisionDetectionUtil
	{
		public function CollisionDetectionUtil()
		{
		}
		/**
		 * 矩形碰撞检测 
		 * @param rect1
		 * @param rect2
		 * @return 
		 * 
		 */
		public static function RectangleCollisionDetection(rect1:Rectangle,rect2:Rectangle):Boolean
		{
			var x1:Number = rect1.x, x2:Number = rect2.x,
				y1:Number = rect1.y, y2:Number = rect2.y,
				width1:Number = rect1.width, width2:Number = rect2.width,
				height1:Number = rect1.height, height2:Number = rect2.height;
			if(x2 < x1 && x1 < x2 + width2 && y2 < y1 && y1 < y2 + height2)return true;
			if(x2 < x1 + width1 && x1+width1 < x2 + width2 && y2 < y1 && y1 < y2 + height2 )return true;
			if(x2 < x1 && x1 < x2 + width2 && y2 < y1+height1 && y1+height1 < y2 + height2)return true;
			if(x2 < x1 + width1 && x1+width1 < x2 + width2 && y2 < y1+height1 && y1+height1 < y2 + height2)return true;
			return false;
		}
	}
}