////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2010-2011 Esri
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package widgets.GeoRSS
{

import com.esri.ags.Graphic;
import com.esri.ags.geometry.Geometry;
import com.esri.ags.geometry.MapPoint;
import com.esri.ags.symbols.Symbol;

import flash.events.EventDispatcher;

[Bindable]

public class GeoRSSFeed extends EventDispatcher
{
    public var content:String;

    public var geometry:Geometry;

    public var symbol:Symbol;

    public var link:String;

    public var point:MapPoint;

    public var title:String;

    public var graphic:Graphic;
}

}
