package net.vis4.streamgraph 
{
	import math.Random;
	import net.vis4.streamgraph.Layer;
	
	/**
	 * LateOnsetData
	 * Creates false data which resembles late onset time-series.
	 * Such as band popularity or movie box-office income.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class LateOnsetDataSource implements DataSource
	{
		public function LateOnsetDataSource(seed:int = 2) {
			// seeded, so we can reproduce results
			Random.seed = seed;
		}
		
		public function make(numLayers:int, sizeArrayLength:int):Vector.<Layer> 
		{
			var layers:Vector.<Layer> = new Vector.<Layer>(numLayers);
			
			for (var i:int = 0; i < numLayers; i++) {
				var name:String = "Layer #" + i,
					onset:int = sizeArrayLength * (Random.next() * 1.25 - 0.25),
					duration:int = Random.next() * 0.75 * sizeArrayLength,
					size:Vector.<Number> = new Vector.<Number>(sizeArrayLength);
				size = makeRandomArray(sizeArrayLength, onset, duration);
				layers[i] = new Layer(name, size);
			}
			
			return layers;
		}
		
		protected function makeRandomArray(sizeArrayLength:int, onset:int, duration:int):Vector.<Number> 
		{
			var x:Vector.<Number> = new Vector.<Number>(sizeArrayLength);
			
			// add a single random bump
			addRandomBump(x, onset, duration);
			
			return x;
		}
		
		protected function addRandomBump(x:Vector.<Number>, onset:int, duration:int):void 
		{
			var height:Number = Random.next(),
				start:int = Math.max(0, onset),
				end:int = Math.min(x.length, onset + duration),
				len:int = end - onset;
				
			for (var i:int = 0; i < x.length && i < onset + duration; i++) {
				var xx:Number = (i - onset) / duration,
					yy:Number = xx * Math.exp( -10 * xx);
				
				x[i] += Math.abs(height * yy);				
			}
		}
		
	}

}