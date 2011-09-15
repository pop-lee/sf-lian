package cn.sftec.www.view
{
	import cn.sftec.www.event.ChangePageEvent;
	import cn.sftech.www.view.SFButton;
	import cn.sftech.www.view.SFContainer;
	
	import flash.events.MouseEvent;
	
	[Embed(source="access/mainPage.swf",symbol="gamePage")]
	public class GamePage extends SFContainer
	{
		public function GamePage()
		{
			super();
			init();
		}
		
		private function init():void
		{
			var gamePane : GamePane = new GamePane();
			gamePane.width = 240;
			gamePane.height = 240;
			gamePane.x = 0;
			gamePane.y = 40;
			gamePane.backgroundAlpha = 0;
			addChild(gamePane);
			
			var _backMainBtn : SFButton = new SFButton();
			_backMainBtn.width = 38;
			_backMainBtn.height = 26;
			_backMainBtn.x = 15;
			_backMainBtn.y = 290;
			_backMainBtn.backgroundAlpha = 0;
			_backMainBtn.addEventListener(MouseEvent.CLICK,toMainPage);
			addChild(_backMainBtn);
			
			var _refreshBtn : SFButton = new SFButton();
			_refreshBtn.width = 38;
			_refreshBtn.height = 26;
			_refreshBtn.x = 185;
			_refreshBtn.y = 290;
			_refreshBtn.backgroundAlpha = 0;
			_refreshBtn.addEventListener(MouseEvent.CLICK,refreshMap);
			addChild(_refreshBtn);
		}
		
		private function toMainPage(event : MouseEvent):void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		
		private function refreshMap(event : MouseEvent):void
		{
			
		}
	}
}