package net.vis4.streamgraph 
{
	import net.vis4.streamgraph.Layer;

	/**
	 * BasicLateOnsetSort
	 * Sorts by onset, but does not partition to the outsides of the graph in
	 * order to illustrate short-sighted errors found during design process.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class BasicLateOnsetSort extends LayerSort 
	{
		
		override public function getName():String 
		{
			return "Late Onset Sorting, Top to Bottom";
		}
		
		override public function sort(layers:Vector.<Layer>):Vector.<Layer> 
		{
			// first sort by onset
			layers.sort(onsetComparator);
			
			return layers;
		}
		
		private function onsetComparator(a:Layer, b:Layer):int 
		{
			return a.onset < b.onset ? -1 : a.onset == b.onset ? 0 : 1;
		}
		
	}

}