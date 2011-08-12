package net.vis4.streamgraph 
{
	import net.vis4.streamgraph.Layer;

	/**
	 * VolatilitySort
	 * Sorts an array of layers by their volatility, placing the most volatile
	 * layers along the outsides of the graph, thus minimizing unneccessary
	 * distortion.
	 *
	 * First sort by volatility, then creates a 'top' and 'bottom' collection.
	 * Iterating through the sorted list of layers, place each layer in whichever
	 * collection has less total mass, arriving at an evenly weighted graph.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class VolatilitySort extends LayerSort 
	{
		
		override public function getName():String 
		{
			return "Volatility Sorting, Evenly Weighted";
		}
		
		override public function sort(layers:Vector.<Layer>):Vector.<Layer> 
		{
			layers.sort(volatilityComparator);
			
			return orderToOutside(layers);
		}
		
		protected function volatilityComparator(a:Layer, b:Layer):int 
		{
			return a.volatility < b.volatility ? -1 : a.volatility > b.volatility ? 1 : 0;
		}
		
	}

}