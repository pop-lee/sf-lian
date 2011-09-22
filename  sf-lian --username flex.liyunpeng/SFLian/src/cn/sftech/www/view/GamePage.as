package cn.sftech.www.view
{
	import cn.sftech.www.event.ChangePageEvent;
	import cn.sftech.www.event.GameOverEvent;
	import cn.sftech.www.model.ModelLocator;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	[Embed(source="access/mainPage.swf",symbol="gamePage")]
	public class GamePage extends SFContainer
	{
		private var gamePane : GamePane;
		
		private var pausePage : PausePage;
		
		private var timerBar : TimerBar;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		public function GamePage()
		{
			super();
			init();
		}
		
		private function init():void
		{
			gamePane = new GamePane(this);
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
			
			pausePage = new PausePage();
			pausePage.visible = false;
			pausePage.addEventListener(MouseEvent.CLICK,toContinue);
			SFApplication.application.addChild(pausePage);
		}
		
		public function startGame() : void
		{
			//创建游戏界面
			gamePane.initGame();
			//计时条回归为满格
			timerBar.countDown();
		}
		
		private function pauseGame(event : MouseEvent) : void
		{
			_model.timer.stop();
			pausePage.visible = true;
			_model.isPaused = true;
			
		}
		
		private function toContinue(event : MouseEvent) : void
		{
			_model.isPaused = false;
			pausePage.visible = false;
			_model.timer.start();
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
			_model.timer.stop();
			_model.timer.reset();
			if(_model.currentScore > 0) {
				gamePane.gameOverHandle();
			} else {
				gamePane.cleanGamePane();
				var changePageEvent : ChangePageEvent = new ChangePageEvent();
				changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
				SFApplication.application.dispatchEvent(changePageEvent);
			}
		}
		
	}
}