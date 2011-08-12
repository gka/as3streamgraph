package net.vis4.streamgraph 
{
	import math.Random;
	import net.vis4.color.Color;
	import net.vis4.streamgraph.Layer;

	/**
	 * RandomColorPicker
	 * Chooses random colors within an acceptable HSB color spectrum
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class RandomColorPicker implements ColorPicker 
	{
		protected var _minHue:Number;
		protected var _maxHue:Number;

		public function RandomColorPicker(seed:int = 2, minHue:Number = 215, maxHue:Number = 236) 
		{
			_maxHue = maxHue;
			_minHue = minHue;
			Random.seed = 2;
		}
		
		public function getName():String 
		{
			return "Random Colors";
		}
		
		public function colorize(layers:Vector.<Layer>):void 
		{
			for (var i:int = 0; i < layers.length; i++) {
				layers[i].rgb = Color.fromHSV(
					Random.float(_minHue, _maxHue), 
					Random.float(0.2, 0.28), 
					Random.float(0.4, 0.95)
				)._int;
			}
		}
		
		public function load(callback:Function):void
		{
			callback();
		}
	}

}