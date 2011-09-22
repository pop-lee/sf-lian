package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class GameOverEvent extends Event
	{
		public static const GAME_OVER_EVENT : String = "gameOverEvent";
		
		public function GameOverEvent()
		{
			super(GAME_OVER_EVENT);
		}
	}
}