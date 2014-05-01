package util
{
    import com.adobe.nativeExtensions.Vibration;

	/**
	 * 震动功能工具类
	 * @author haojie.wang
	 * 
	 */
    public class VibrationUtil
    {
        public function VibrationUtil()
        {
        }

		/**
		 * 调用设备的震动功能 
		 * @param duration
		 * 
		 */		
        static public function vibration(duration:Number):void
        {
            try
            {
                if(Vibration.isSupported)
                {
                    new Vibration().vibrate(200);
                }
            }
            catch(e:Error)
            {
				trace("设备不支持震动");
            }
        }
    }
}
