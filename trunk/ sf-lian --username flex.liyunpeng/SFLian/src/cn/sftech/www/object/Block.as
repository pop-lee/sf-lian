package cn.sftech.www.object
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Block extends MovieClip
	{
		public static const CHESSMAN_LENGTH : int = 30;
		
		public static const TYPE_1 : int = 1;
		public static const TYPE_2 : int = 2;
		public static const TYPE_3 : int = 3;
		public static const TYPE_4 : int = 4;
		public static const TYPE_5 : int = 5;
		public static const TYPE_6 : int = 6;
		public static const TYPE_7 : int = 7;
		public static const TYPE_8 : int = 8;
		public static const TYPE_9 : int = 9;
		
		public var mapX : int;
		public var mapY : int;
		
		public var type : int;
		
		public var isCheckIn : Boolean = false;
		
		public function Block(type : int)
		{
			this.type = type;
			super();
		}
		
		public function setData(x : int,y : int) : void
		{
			mapX = x;
			mapY = y;
		}
		
	}
}