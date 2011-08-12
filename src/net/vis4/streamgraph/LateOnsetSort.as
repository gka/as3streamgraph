package net.vis4.streamgraph 
{
	import net.vis4.streamgraph.Layer;
	
	/**
	 * LateOnsetSort
	 * Sorts by onset, and orders to the outsides of the graph.
	 *
	 * This is the sort technique preferred when using late-onset data, which the
	 * Streamgraph technique is best suited to represent
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class LateOnsetSort extends LayerSort 
	{
		
		override public function getName():String 
		{
			return "Late Onset Sorting, Evenly Weighted";
		}
		
		override public function sort(layers:Vector.<Layer>):Vector.<Layer> 
		{
			// first sort by onset
			layers.sort(onsetComparator);
			
			return orderToOutside(layers);
		}
		
		protected function onsetComparator(a:Layer, b:Layer):int 
		{
			return a.onset < b.onset ? -1 : a.onset > b.onset ? 1 : 0;
		}
		
	}

}