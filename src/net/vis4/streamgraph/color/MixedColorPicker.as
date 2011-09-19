package net.vis4.streamgraph.color 
{
	import net.vis4.color.Color;
	import net.vis4.streamgraph.color.ColorPicker;
	import net.vis4.streamgraph.Layer;
	
	/**
	 * Use this Colorpicker for animated transitions between two color modes
	 * 
	 * @author Gregor Aisch
	 */
	public class MixedColorPicker implements ColorPicker 
	{
		protected var _cp1:ColorPicker;
		protected var _cp2:ColorPicker;
		protected var _f:Number;
		protected var _mode:String;
		
		public function MixedColorPicker(cp1:ColorPicker, cp2:ColorPicker, f:Number = 0, mode:String = 'hsv') 
		{
			_mode = mode;
			_f = f;
			_cp2 = cp2;
			_cp1 = cp1;
			
		}
		
		/* INTERFACE net.vis4.streamgraph.ColorPicker */
		
		public function colorize(layers:Vector.<Layer>):void 
		{
			var l1:Vector.<Layer> = cloneLayers(layers);
			var l2:Vector.<Layer> = cloneLayers(layers);
			_cp1.colorize(l1);
			_cp2.colorize(l2);
			
			trace(_cp1.getName(), _cp2.getName());
			
			for (var i:uint = 0; i < layers.length; i++) {
				
				if (layers[i].name == 'uranium') trace(_f, l1[i].rgb, '>', Color.map(l1[i].rgb, l2[i].rgb, _f, _mode), '>', l2[i].rgb);
				
				layers[i].rgb = Color.map(l1[i].rgb, l2[i].rgb, _f, _mode);
				
				if (l1[i].topLineRGB == -1 && l2[i].topLineRGB != -1) {
					layers[i].topLineRGB = l2[i].topLineRGB;
					layers[i].topLineAlpha = l2[i].topLineAlpha * _f;
				} else if (l1[i].topLineRGB != -1 && l2[i].topLineRGB == -1) {
					layers[i].topLineRGB = l1[i].topLineRGB;
					layers[i].topLineAlpha = l1[i].topLineAlpha * (1-_f);
				} else if (l1[i].topLineRGB != -1) {
					layers[i].topLineRGB = Color.map(l1[i].topLineRGB, l2[i].topLineRGB, _f, _mode);
					layers[i].topLineAlpha = l1[i].topLineAlpha * (1 - _f) + l2[i].topLineAlpha * _f;
				}
				
				if (l1[i].bottomLineRGB == -1 && l2[i].bottomLineRGB != -1) {
					layers[i].bottomLineRGB = l2[i].bottomLineRGB;
					layers[i].bottomLineAlpha = l2[i].bottomLineAlpha * _f;
				} else if (l1[i].bottomLineRGB != -1 && l2[i].bottomLineRGB == -1) {
					layers[i].bottomLineRGB = l1[i].bottomLineRGB;
					layers[i].bottomLineAlpha = l1[i].bottomLineAlpha * (1-_f);
				} else if (l1[i].bottomLineRGB != -1) {
					layers[i].bottomLineRGB = Color.map(l1[i].bottomLineRGB, l2[i].bottomLineRGB, _f, _mode);
					layers[i].bottomLineAlpha = l1[i].bottomLineAlpha * (1 - _f) + l2[i].bottomLineAlpha * _f;
				}
			}
		}
		
		public function getName():String 
		{
			return "Mixed Color Picker"
		}
		
		public function load(callback:Function):void 
		{
			callback();
		}
		
		protected static function cloneLayers(layers:Vector.<Layer>):Vector.<Layer>
		{
			var res:Vector.<Layer> = new Vector.<Layer>();
			for each (var l:Layer in layers) {
				res.push(l.clone());
			}
			return res;
		}
	}

}