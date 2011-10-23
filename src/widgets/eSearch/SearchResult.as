////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2010 ESRI
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package widgets.eSearch
{

	import com.esri.ags.Graphic;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.symbols.Symbol;

	import flash.events.EventDispatcher;

	[Bindable]
	[RemoteClass(alias="widgets.eSearch.SearchResult")]

	public class SearchResult extends EventDispatcher
	{
	    public var title:String;

	    public var symbol:Symbol;

		public var icon:String;

	    public var content:String;

	    public var point:MapPoint;

	    public var link:String;

		public var linkalias:String;

	    public var geometry:Geometry;

		public var graphic:Graphic;

		public var selected:Boolean;

		public var gid:Number;

		public var multi:String;

		public var linkicon:String;
	}

}
