package cn.sftec.www.model
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Timer;

	public class ModelLocator
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		/**
		 * 当前关数
		 */		
		public var currentLv : uint = 1;
		
		/**
		 * 总分数排行榜列表数组
		 */
		public var topScoreArr : Vector.<int> = new Vector.<int>;
		
		/**
		 * 当前分数
		 */		
		public var currentScore : uint = 0;
		
		/**
		 * 当前计时数
		 */
		public var currentTimerCount : int = 0;
		
		/**
		 * 倒数限制时间秒数(单位:1/2秒)
		 */
		public var limitTime : uint = 60;
		
		/**
		 * 消去一块的分数
		 */		
		public static const BODY_SCORE : uint = 10;
		
		/**
		 * 计时器单位(单位:毫秒)
		 */		
		public const TIMER_UTIL : uint = 500;
		
		/**
		 * 消除一对回退秒数(单位:秒)
		 */		
		public const BACK_TIME : Number = 1.5;
		
		/**
		 * 连击间隔时间(单位:1/2秒)
		 */		
		public const BATTER_TIME : uint = 3;
		
		/**
		 * 游戏进行中的倒数计时器(单位:100毫秒)
		 */		
		public var timer : Timer = new Timer(TIMER_UTIL);
		
		/**
		 * 定义刷新次数
		 */		
		public const REFRESH_COUNT : uint = 3;
		
		/**
		 * 定义刷新次数计数
		 */
		public var refreshCount : uint = REFRESH_COUNT;
		
		/**
		 * 游戏是否暂停的标签
		 */		
		public var isPaused : Boolean = false;
		
		public function ModelLocator()
		{
			if(_model != null) {
				throw new IllegalOperationError("这是一个单例类，请使用getInstance方法来获取对象");
			}
		}
		
		public static function getInstance() : ModelLocator
		{
			return _model;
		}
		
	}
}