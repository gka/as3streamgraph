package net.vis4.streamgraph 
{
	import math.Random;
	
	/**
	 * BelievableDataSource
	 * Create test data for layout engine.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class BelievableDataSource implements DataSource 
	{
		
		public function BelievableDataSource(seed:int = 2) {
			// seeded, so we can reproduce results
			Random.seed = seed;
		}
		
		public function make(numLayers:int, sizeArrayLength:int):Vector.<Layer>
		{
			var layers:Vector.<Layer> = new Vector.<Layer>(numLayers);
			
			for (var i:int = 0; i < numLayers; i++) {
				var name:String = "Layer #" + i;
				var size:Vector.<Number> = new Vector.<Number>(sizeArrayLength);
				size = makeRandomArray(sizeArrayLength);
				layers[i] = new Layer(name, size);
			}
			
			return layers;
		}
		
		protected function makeRandomArray(n:int):Vector.<Number>
		{
			var x:Vector.<Number> = new Vector.<Number>(n);
			
			// add a handful of random bumps
			for (var i:int=0; i<5; i++) {
				addRandomBump(x);
			}
			
			return x;
		}
		
		protected function addRandomBump(x:Vector.<Number>):void
		{
			var height:Number = 1 / Random.next(),
				cx:Number = 2 * Random.next() - 0.5,
				r:Number = Random.next() / 10;
				
			for (var i:int = 0; i < x.length; i++) {
				var a:Number = (i / x.length - cx) / r;
				x[i] = height * Math.exp( -a * a);
			}
		}
		
	}

}