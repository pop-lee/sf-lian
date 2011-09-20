package cn.sftec.www.view
{
	import cn.sftec.www.model.ModelLocator;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import mx.effects.Move;
	
	public class TimerBar extends MovieClip
	{
		[Embed(source="access/mainPage.swf",symbol="TimerBar1")]
		private var cls1 : Class;
		[Embed(source="access/mainPage.swf",symbol="TimerBar2")]
		private var cls2 : Class;
		
		private var timeBar1 : DisplayObject;
		private var timebar2 : DisplayObject;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function TimerBar()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			
			//时间条底色
			timeBar1 = new cls1();
			//时间条
			timebar2 = new cls2();
			addChild(timeBar1);
			addChild(timebar2);
		}
		
		public function countDown() : void
		{
			timebar2.scaleX = (_model.limitTime - _model.currentTimerCount)/_model.limitTime;
		}
	}
}