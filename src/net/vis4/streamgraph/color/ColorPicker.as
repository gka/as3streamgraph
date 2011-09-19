package net.vis4.streamgraph.color 
{
	import net.vis4.streamgraph.Layer;
	
	/**
	 * ColorPicker
	 * Interface for new coloring algorithms.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public interface ColorPicker 
	{
		function colorize(layers:Vector.<Layer>):void;
		
		function getName():String;
		
		function load(callback:Function):void;
	}
	
}