package cn.sftec.www.view
{
	import cn.sftec.www.event.ChangePageEvent;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFContainer;
	import cn.sftech.www.view.SFSprite;
	
	import flash.events.MouseEvent;
	
	[Embed(source="access/mainPage.swf",symbol="mainPage")]
	public class MainPage extends SFContainer
	{
		public function MainPage()
		{
			super();
			init();
		}
		
		private function init():void
		{
			var startGameBtn : SFSprite = new SFSprite();
			startGameBtn.x = 155;
			startGameBtn.y = 110;
			startGameBtn.width = 67;
			startGameBtn.height = 54;
			startGameBtn.backgroundAlpha = 0;
			startGameBtn.addEventListener(MouseEvent.CLICK,startGameHandle);
			this.addChild(startGameBtn);
			
			var scoreListBtn : SFSprite = new SFSprite();
			scoreListBtn.x = 40;
			scoreListBtn.y = 180;
			scoreListBtn.width = 60;
			scoreListBtn.height = 40;
			scoreListBtn.backgroundAlpha = 0;
			scoreListBtn.addEventListener(MouseEvent.CLICK,scoreListHandle);
			this.addChild(scoreListBtn);
			
			var intrGameBtn : SFSprite = new SFSprite();
			intrGameBtn.x = 65;
			intrGameBtn.y = 95
			intrGameBtn.width = 60;
			intrGameBtn.height = 40;
			intrGameBtn.backgroundAlpha = 0;
			intrGameBtn.addEventListener(MouseEvent.CLICK,intrGameHandle);
			this.addChild(intrGameBtn);
			
			var exitBtn : SFSprite = new SFSprite();
			exitBtn.x = 155;
			exitBtn.y = 278;
			exitBtn.width = 65;
			exitBtn.height = 30;
			exitBtn.backgroundAlpha = 0;
			exitBtn.addEventListener(MouseEvent.CLICK,exitGameHandle);
			this.addChild(exitBtn);
		}
		
		private function startGameHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_GAME_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		private function scoreListHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_SCORELIST_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		private function intrGameHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_INTR_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		private function exitGameHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.EXIT;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
	}
}