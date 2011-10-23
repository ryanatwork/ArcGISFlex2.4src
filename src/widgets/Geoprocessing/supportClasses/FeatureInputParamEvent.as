////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2011 Esri
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package widgets.Geoprocessing.supportClasses
{

import flash.events.Event;

import widgets.Geoprocessing.parameters.IGPFeatureParameter;

public class FeatureInputParamEvent extends Event
{
    public static const DRAW:String = "drawFeature";
    public static const CLEAR:String = "clearFeature";

    public var featureParam:IGPFeatureParameter;
    public var drawType:String;

    public function FeatureInputParamEvent(type:String, featureParam:IGPFeatureParameter, drawType:String = null, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        this.featureParam = featureParam;
        this.drawType = drawType;
        super(type, bubbles, cancelable);
    }

    override public function clone():Event
    {
        return new FeatureInputParamEvent(type, featureParam, drawType, bubbles, cancelable);
    }
}

}
