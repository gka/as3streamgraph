package net.vis4.streamgraph 
{
	import flash.display.BitmapData;
	/**
	* Layer
	* Represents a layer in a layered graph, maintaining properties which
	* define it's position, size, color and mathemetical characteristics
	*
	* @author Lee Byron
	* @author Martin Wattenberg
	*/
	public class Layer 
	{
		public var name:String;
		public var size:Vector.<Number>;
		public var yBottom:Vector.<Number>;
		public var yTop:Vector.<Number>;
		public var rgb:int;
		public var onset:int;
		public var end:int;
		public var sum:Number;
		public var volatility:Number;
		public var bitmapFill:BitmapData;
		public var topLineRGB:int = -1;
		public var topLineAlpha:Number = 1;
		public var bottomLineRGB:int = -1;
		public var bottomLineAlpha:Number = 1;
		
		public function Layer(name:String, size:Vector.<Number>) 
		{
			// check for reasonable data
			for (var i:int = 0; i < size.length; i++) {
				if (size[i] < 0) throw new ArgumentError("No negative sizes allowed.");
			}
			
			this.name = name;
			this.size = size;
			yBottom = new Vector.<Number>(size.length);
			yTop = new Vector.<Number>(size.length);
			sum = 0;
			volatility = 0;
			onset = -1;
			
			for (i = 0; i < size.length; i++) {
				// sum is the summation of all points
				sum += size[i];
				
				// onset is the first non-zero point
				// end is the last non-zero point
				if (size[i] > 0) {
					if (onset == -1) {
						onset = i;
					} else {
						end = i;
					}
				}
				
				// volatility is the maximum change between any two consecutive points
				if (i > 0) {
					volatility = Math.max(
						volatility,
						Math.abs(size[i] - size[i-1])
					);
				}		
			}
		}	
		
		public function clone():Layer
		{
			var c:Layer = new Layer(name, size.concat());
			c.bitmapFill = bitmapFill;
			c.bottomLineAlpha = bottomLineAlpha;
			c.bottomLineRGB = bottomLineRGB;
			c.end = end;
			c.onset = onset;
			c.rgb = rgb;
			c.sum = sum;
			c.topLineAlpha = topLineAlpha;
			c.topLineRGB = topLineRGB;
			c.volatility = volatility;
			c.yBottom = yBottom.concat();
			c.yTop = yTop.concat();
			return c;
		}
	}
}