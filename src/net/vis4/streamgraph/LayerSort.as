package net.vis4.streamgraph
{
	/**
	 * LayerSort
	 * Interface to sorting layers
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class LayerSort 
	{
		
		public function getName():String { return "" }
		
		public function sort(layers:Vector.<Layer>):Vector.<Layer> { return null;  };
		
		/**
		 * Creates a 'top' and 'bottom' collection.
		 * Iterating through the previously sorted list of layers, place each layer
		 * in whichever collection has less total mass, arriving at an evenly
		 * weighted graph. Reassemble such that the layers that appeared earliest
		 * end up in the 'center' of the graph.
		 */
		protected function orderToOutside(layers:Vector.<Layer>):Vector.<Layer> 
		{
			var j:int = 0, 
				n:int = layers.length, 
				newLayers:Vector.<Layer> = new Vector.<Layer>(n),
				topCount:int = 0,
				topSum:Number = 0,
				topList:Vector.<int> = new Vector.<int>(n),
				botCount:int = 0,
				botSum:Number = 0,
				botList:Vector.<int> = new Vector.<int>(n);
				
			// partition to top or bottom containers
			for (var i:int = 0; i < n; i++) {
				if (topSum < botSum) {
					topList[topCount++] = i;
					topSum += layers[i].sum;
				} else {
					botList[botCount++] = i;
					botSum += layers[i].sum;
				}
			}
			
			// reassemble into single array
			for (i = botCount - 1; i >= 0; i--) {
				newLayers[j++] = layers[botList[i]];
			}
			for (i = 0; i < topCount; i++) {
				newLayers[j++] = layers[topList[i]];
			}
			return newLayers;
		}
	}
}