package cn.sftech.www.object
{
	import cn.sftech.www.util.MathUtil;
	
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.system.System;

	public class MapData
	{
		/**
		 * Map总行数
		 */
		public const TOTAL_ROW : int = 10;
		/**
		 * Map总列数
		 */
		public const TOTAL_COL : int = 10;
		
		//显示块总行数
		private const BLOCK_TOTAL_ROW : int = 2;
		//显示块总列数
		private const BLOCK_TOTAL_COL : int = 1;
		
		/**
		 * 地图存储数据二维数组
		 */
		public var mapArr : Vector.<Vector.<Block>> = new Vector.<Vector.<Block>>;
		
		/**
		 * 存储现存的块
		 */
		public var mapBlockArr : Vector.<Block> = new Vector.<Block>(BLOCK_TOTAL_ROW*BLOCK_TOTAL_COL);
		
		public function MapData()
		{
			init();
		}
		
		private function init() : void
		{
			for(var i : int = 0;i < TOTAL_ROW;i++) {
				mapArr.push(new Vector.<Block>(TOTAL_COL));
			}
		}
		
		/**
		 * 创建关数地图的二维数组数据
		 * @param lv 要创建地图的关数
		 * 
		 */		
		public function createMapData(lv : int):void
		{
			var blockType : Vector.<Class> = Vector.<Class>([Block1,Block2,Block3,Block4]);
			if(lv>1)
				blockType.push(Block5);
			if(lv>2)
				blockType.push(Block6);
			if(lv>3)
				blockType.push(Block7);
			if(lv>4)
				blockType.push(Block8);
			if(lv>5)
				blockType.push(Block9);
			
			var blockCount : int = 0;
			for(var i : int = 1;i <= BLOCK_TOTAL_ROW;i++) {
				for(var j : int = 1;j <= BLOCK_TOTAL_COL;j++) {
					var cls : Class = blockType[int(blockCount/2)%blockType.length] as Class;
					var block : Block = new cls();
					block.setData(j,i);
					mapArr[i][j] = block;
					mapBlockArr[blockCount] = block;
					blockCount ++;
				}
			}
		}
		
		public function cleanMapData():void
		{
			while(mapBlockArr.length > 0) {
				removeBlock(mapBlockArr[0]);
			}
		}
		
		/**
		 * 洗牌整个地图的数据
		 */
		public function shuffle() : void
		{
			var tmpX : int;
			var tmpY : int;
			for(var i : int = 0;i < 2000; i++) {
				var blockAIndex : int = MathUtil.random(0,mapBlockArr.length);
				var blockBIndex : int = MathUtil.random(0,mapBlockArr.length);
				
				var blockA : Block = mapBlockArr[blockAIndex];
				var blockB : Block = mapBlockArr[blockBIndex];
				
				tmpX = blockB.mapX;
				tmpY = blockB.mapY;
				blockB.setData(blockA.mapX,blockA.mapY);
				blockA.setData(tmpX,tmpY);
				mapArr[blockA.mapY][blockA.mapX] = blockA;
				mapArr[blockB.mapY][blockB.mapX] = blockB;
			}
		}
		
		public function removeBlock(block : Block) : void
		{
			mapArr[block.mapY][block.mapX] = null;
			mapBlockArr.splice(mapBlockArr.indexOf(block),1);
			
			System.gc();
		}
	}
}