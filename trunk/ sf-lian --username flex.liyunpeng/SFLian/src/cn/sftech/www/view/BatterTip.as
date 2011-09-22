package cn.sftech.www.view
{
	
	import flash.events.Event;
	
	public class BatterTip extends SFSprite
	{
		private const DELTA_ALPHA:Number = 0.03;
		
		private var batterCount : NumText;
		
		public function BatterTip()
		{
			super();
			init();
			this.addEventListener(Event.ENTER_FRAME,enterFrameHandle);
		}
		
		private function init():void
		{
			this.alpha = 0;
			batterCount = new NumText();
			batterCount.label.text = "20";
			addChild(batterCount);
			
			var batterText : BatterText = new BatterText();
			batterText.x = 25;
			addChild(batterText);
		}
		
		public function setBatterCount(count : int) : void
		{
			if(count > 0) {
				alpha = 1;
				batterCount.label.text = count + "";
			}
		}
		
		private function enterFrameHandle(event : Event) : void
		{
			if(alpha > 0) 
				this.alpha -= DELTA_ALPHA;
		}
	}
}