package cn.sftech.www.event
{
	import flash.events.Event;
	
	public class ChangePageEvent extends Event
	{
		public static const CHANGE_PAGE_EVENT : String = "changePageEvent";
		
		public static const TO_MAIN_PAGE : int = 0;
		
		public static const TO_GAME_PAGE : int = 1;
		
		public static const TO_INTR_PAGE : int = 2;
		
		public static const TO_SCORELIST_PAGE : int = 3;
		
		public static const EXIT : int = 4;
		
		public var data : int;
		
		public function ChangePageEvent()
		{
			super(CHANGE_PAGE_EVENT);
		}
	}
}