package cn.sftech.www.view {
	
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	
	public class ConnectLines extends Sprite {
		protected const DELTA_ALPHA:Number = 0.08;
		protected var m_connectLinesPanel:Sprite;
		protected var m_width:Number;
		protected var m_height:Number;
//		protected var m_sound:Sound;
		
		public function ConnectLines() {
//			m_connectLinesPanel = new Sprite();
//			parentMC.addChild(m_connectLinesPanel);
//			m_sound = new SConnectSuccess();
		}
		
		public function setChessmanSize(w:Number, h:Number):void {
			m_width = w;
			m_height = h;
		}
		
		public function addConnectLines(paths:Array):void {
			var panel:Sprite = new Sprite();
			panel.graphics.clear();
			panel.graphics.lineStyle(4, 0xffffff);
			panel.graphics.moveTo(paths[0] * m_width + m_width / 2, paths[1] * m_height + m_height / 2);
			for (var i:uint = 2; i < paths.length; i += 2) {
				panel.graphics.lineTo(paths[i] * m_width + m_width / 2, paths[i + 1] * m_height + m_height / 2);
			}
			panel.addEventListener(Event.ENTER_FRAME, onEnterFrame_handler);
//			var bubble1:MCBubble = new MCBubble();
//			bubble1.x = paths[0] * m_width + m_width / 2;
//			bubble1.y = paths[1] * m_height + m_height / 2;
//			var bubble2:MCBubble = new MCBubble();
//			bubble2.x = paths[(paths.length - 2)] * m_width + m_width / 2;
//			bubble2.y = paths[(paths.length - 1)] * m_height + m_height / 2;
//			panel.addChild(bubble1);
//			panel.addChild(bubble2);
			this.addChild(panel);
//			m_sound.play(100);
		}
		
		private function onEnterFrame_handler(e:Event):void {
			var panel:Sprite = e.currentTarget as Sprite;
//			//判断白色气泡是否播放到要结束的位置
//			var bubble1:MCBubble = panel.getChildAt(0) as MCBubble;
//			if (bubble1.currentFrame >= 15) {
				panel.alpha -= DELTA_ALPHA;
//			}
			if (panel.alpha <= 0) {
				panel.removeEventListener(Event.ENTER_FRAME, onEnterFrame_handler);
				this.removeChild(panel);
			}
		}
	}
}