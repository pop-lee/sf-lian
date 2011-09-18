package cn.sftec.www.view
{
	import cn.sftec.www.event.ChangePageEvent;
	import cn.sftec.www.event.GameOverEvent;
	import cn.sftec.www.model.ModelLocator;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFButton;
	import cn.sftech.www.view.SFContainer;
	
	import com.qq.openapi.MttScore;
	
	import flash.events.MouseEvent;
	import flash.system.System;
	
	public class GameOverPage extends SFContainer
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var submitScoreTip : SubmitScoreTip;
		
		private var submitBtn : SFButton;
		
		private var canelBtn : SFButton;
		
		private var okBtn : SFButton;
		
		public function GameOverPage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			var gameOverTip : GameOverTip = new GameOverTip();
			gameOverTip.x = 5;
			gameOverTip.y = 40;
			addChild(gameOverTip);
			
			submitScoreTip = new SubmitScoreTip();
			submitScoreTip.x = 5;
			submitScoreTip.y = 192;
			addChild(submitScoreTip);
			
			submitBtn = new SFButton();
			submitBtn.x = 7;
			submitBtn.y = 284;
			submitBtn.width = 33;
			submitBtn.height = 35;
			submitBtn.backgroundAlpha = 0;
			submitBtn.addEventListener(MouseEvent.CLICK,submitScore);
			addChild(submitBtn);
			
			canelBtn = new SFButton();
			canelBtn.x = 200;
			canelBtn.y = 284;
			canelBtn.width = 33;
			canelBtn.height = 35;
			canelBtn.backgroundAlpha = 0;
			canelBtn.addEventListener(MouseEvent.CLICK,canelSubmit);
			addChild(canelBtn);
			
			okBtn = new SFButton();
			okBtn.x = 79;
			okBtn.y = 284;
			okBtn.width = 79;
			okBtn.height = 35;
			okBtn.backgroundAlpha = 0;
			okBtn.addEventListener(MouseEvent.CLICK,okHandle);
		}
		
		public function submitScore(event : MouseEvent) : void
		{
//			MttScore.submit(_model.currentScore,submitRequest);
			submitRequest();
		}
		
		private function canelSubmit(event : MouseEvent) : void
		{
			gameOver();
		}
		
		private function submitRequest(result : Object = null):void
		{
			submitScoreTip.gotoAndStop(2);
			addChild(okBtn);
		}
		
		private function okHandle(event : MouseEvent) : void
		{
			gameOver();
		}
		
		private function gameOver() : void
		{
			removeSelf();
			this.dispatchEvent(new GameOverEvent());
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		
		private function removeSelf():void
		{
			if(submitBtn.hasEventListener(MouseEvent.CLICK))
				submitBtn.removeEventListener(MouseEvent.CLICK,submitScore);
			if(canelBtn.hasEventListener(MouseEvent.CLICK))
				canelBtn.removeEventListener(MouseEvent.CLICK,canelSubmit);
			if(okBtn.hasEventListener(MouseEvent.CLICK))
				okBtn.removeEventListener(MouseEvent.CLICK,okHandle);
			
			SFApplication.application.removeChild(this);
			System.gc();
		}
	}
}