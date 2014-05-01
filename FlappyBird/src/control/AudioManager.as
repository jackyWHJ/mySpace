package control
{
	import flash.errors.IOError;
	import flash.media.Sound;
	import flash.utils.Dictionary;

	/**
	 * 音效管理类 
	 * @author haojie.wang
	 * 
	 */
	public class AudioManager
	{
		
		/**
		 * mp3声音数组 
		 */
		private var _mp3SoundDic:Dictionary;
		public function AudioManager()
		{
			_mp3SoundDic = new Dictionary();
		}
		
		/**
		 * 添加MP3 
		 * 
		 */
		public function addMp3Sound(id:String,mp3:Sound):void
		{
			_mp3SoundDic[id] = mp3;
		}
		
		/**
		 * 删除Mp3 
		 * @param id
		 * 
		 */
		public function deleteMp3Sound(id:String):void
		{
			_mp3SoundDic[id] = null;
			delete _mp3SoundDic[id];
		}
		
		/**
		 *  播放Mp3
		 * @param id
		 * 
		 */
		public function playMp3Sound(id:String):void
		{
			if(mp3SoundDic[id] is Sound)
			{
				Sound(mp3SoundDic[id]).play();
			}
			else
			{
				trace("找不到Mp3文件"+id);
			}
		}
		
		/**
		 * 停止播放Mp3 
		 * @param id
		 * 
		 */
		public function stopMp3Sound(id:String):void
		{
			if(mp3SoundDic[id] is Sound)
			{
				try {
					Sound(mp3SoundDic[id]).close();
				}
				catch (error:IOError) {
					trace("Couldn't close stream " + error.message);    
				}
				
			}
			else
			{
				trace("找不到Mp3文件"+id);
			}
		}
		
		/**
		 * mp3声音数组 
		 */
		public function get mp3SoundDic():Dictionary
		{
			return _mp3SoundDic;
		}
		
		/**
		 * @private
		 */
		public function set mp3SoundDic(value:Dictionary):void
		{
			_mp3SoundDic = value;
		}

	}
}