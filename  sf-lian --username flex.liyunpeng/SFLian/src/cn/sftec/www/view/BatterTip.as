package cn.sftec.www.view
{
	import cn.sftech.www.view.SFSprite;
	
	import flash.events.Event;
	
	public class BatterTip extends SFSprite
	{
		private const DELTA_ALPHA:Number = 0.08;
		
		public function BatterTip()
		{
			super();
			init();
			this.addEventListener(Event.ENTER_FRAME,enterFrameHandle);
		}
		
		private function init():void
		{
			this.alpha = 0;
			var batterText : BatterText = new BatterText();
			addChild(batterText);
		}
		
		public function setBatterCount(count : uint) : void
		{
			if(count > 0)
				alpha = 1;
		}
		
		private function enterFrameHandle(event : Event) : void
		{
			if(alpha > 0) 
				this.alpha -= DELTA_ALPHA;
		}
	}
}