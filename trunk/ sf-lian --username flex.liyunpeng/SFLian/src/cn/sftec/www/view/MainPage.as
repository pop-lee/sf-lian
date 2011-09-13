package cn.sftec.www.view
{
	import cn.sftech.www.view.SFContainer;
	import cn.sftech.www.view.SFSprite;
	import cn.sftec.www.event.ChangePageEvent;
	
	import flash.events.MouseEvent;
	
	public class MainPage extends SFContainer
	{
		public function MainPage()
		{
			super();
		}
		
		private function init():void
		{
			var startGameBtn : SFSprite = new SFSprite();
			startGameBtn.width = 60;
			startGameBtn.height = 60;
			startGameBtn.addEventListener(MouseEvent.CLICK,startGameHandle);
			this.addChild(startGameBtn);
			
			var scoreListBtn : SFSprite = new SFSprite();
			scoreListBtn.width = 60;
			scoreListBtn.height = 60;
			scoreListBtn.addEventListener(MouseEvent.CLICK,scoreListHandle);
			this.addChild(scoreListBtn);
			
			var intrGameBtn : SFSprite = new SFSprite();
			intrGameBtn.width = 60;
			intrGameBtn.height = 60;
			intrGameBtn.addEventListener(MouseEvent.CLICK,intrGameHandle);
			this.addChild(intrGameBtn);
			
			var exitBtn : SFSprite = new SFSprite();
			exitBtn.width = 60;
			exitBtn.height = 60;
			exitBtn.addEventListener(MouseEvent.CLICK,exitGameHandle);
			this.addChild(exitBtn);
		}
		
		private function startGameHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_GAME_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		private function scoreListHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_SCORELIST_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		private function intrGameHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_INTR_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		private function exitGameHandle(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.EXIT;
			this.dispatchEvent(changePageEvent);
		}
	}
}