package cn.sftec.www.view
{
	import cn.sftec.www.event.ChangePageEvent;
	import cn.sftec.www.event.GameOverEvent;
	import cn.sftec.www.model.ModelLocator;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFButton;
	import cn.sftech.www.view.SFContainer;
	import cn.sftech.www.view.SFLabel;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	[Embed(source="access/mainPage.swf",symbol="gamePage")]
	public class GamePage extends SFContainer
	{
		private var gamePane : GamePane;
		
		private var timerBar : TimerBar;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function GamePage()
		{
			super();
			init();
		}
		
		private function init():void
		{
			gamePane = new GamePane();
			gamePane.width = 240;
			gamePane.height = 240;
			gamePane.x = 0;
			gamePane.y = 36;
			gamePane.backgroundAlpha = 0;
			addChild(gamePane);
			_model.timer.addEventListener(TimerEvent.TIMER,timeHandle);
			
			timerBar = new TimerBar();
			timerBar.x = 66;
			timerBar.y = 300;
			addChild(timerBar);
			
			var _pauseBtn : SFButton = new SFButton();
			_pauseBtn.width = 30;
			_pauseBtn.height = 30;
			_pauseBtn.x = 202;
			_pauseBtn.y = 4;
			_pauseBtn.backgroundAlpha = 0;
			_pauseBtn.addEventListener(MouseEvent.CLICK,pauseGame);
			addChild(_pauseBtn);
			
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
			
			var lvLabel : SFLabel = new SFLabel();
			lvLabel.text = _model.currentLv + "";
			lvLabel.x = 43;
			lvLabel.y = 1;
			lvLabel.width = 60;
			lvLabel.height = 27;
			lvLabel.size = 40;
			lvLabel.color = 0xff0000;
			lvLabel.font = (new ModelLocator.font()).fontName;
			addChild(lvLabel);
			
		}
		
		public function startGame() : void
		{
			//创建游戏界面
			gamePane.startGame();
			//计时条回归为满格
			timerBar.countDown();
		}
		
		private function pauseGame(event : MouseEvent) : void
		{
			_model.timer.stop();
		}
		
		private function timeHandle(event : TimerEvent) :void
		{
			_model.currentTimerCount++;
			
			timerBar.countDown();
			
			//当游戏失败
			if(_model.currentTimerCount >= _model.limitTime) {
				_model.timer.stop();
				_model.timer.reset();
				gamePane.gameOverHandle();
			}
		}
		
		private function toMainPage(event : MouseEvent):void
		{
			if(_model.currentScore > 0) {
				_model.timer.stop();
				_model.timer.reset();
				gamePane.gameOverHandle();
			}
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
		
		private function refreshMap(event : MouseEvent):void
		{
			gamePane.rebuild();
		}
	}
}