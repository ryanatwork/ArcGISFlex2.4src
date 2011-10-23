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
package widgets.Geoprocessing.parameters
{

import com.esri.ags.tasks.supportClasses.LinearUnit;

import widgets.Geoprocessing.supportClasses.UnitMappingUtil;

public class LinearUnitParameter extends BaseParameter
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    private function linearUnitString():String
    {
        return _defaultValue.distance + ":" + UnitMappingUtil.toPrettyUnits(_defaultValue.units);
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  defaultValue
    //----------------------------------

    private var _defaultValue:LinearUnit;

    override public function get defaultValue():Object
    {
        return _defaultValue;
    }

    override public function set defaultValue(value:Object):void
    {
        _defaultValue = new LinearUnit(value.distance, value.units);
    }

    //----------------------------------
    //  type
    //----------------------------------

    override public function get type():String
    {
        return GPParameterTypes.LINEAR_UNIT;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function defaultValueFromString(description:String):void
    {
        var linearUnitTokens:Array = description.split(':');
        _defaultValue = new LinearUnit(linearUnitTokens[0], UnitMappingUtil.toEsriUnits((linearUnitTokens[1])));
    }
}

}
