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

public class LongParameter extends BaseParameter
{
    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  defaultValue
    //----------------------------------

    private var _defaultValue:int;

    override public function get defaultValue():Object
    {
        return _defaultValue;
    }

    override public function set defaultValue(value:Object):void
    {
        _defaultValue = value as int;
    }

    //----------------------------------
    //  type
    //----------------------------------

    override public function get type():String
    {
        return GPParameterTypes.LONG;
    }

    //--------------------------------------------------------------------------
    //
    //  Overriden methods
    //
    //--------------------------------------------------------------------------

    override public function defaultValueFromString(description:String):void
    {
        defaultValue = parseInt(description);
    }

    public override function hasValidValue():Boolean
    {
        return !isNaN(_defaultValue);
    }
}

}
