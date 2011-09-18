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
		
		public var timer : Timer = new Timer(1000);
		
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