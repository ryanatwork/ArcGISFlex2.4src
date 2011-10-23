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

import com.esri.ags.tasks.supportClasses.DataFile;

public class DataFileParameter extends BaseParameter
{
    //--------------------------------------------------------------------------
    //
    //  Constants
    //
    //--------------------------------------------------------------------------

    private static const URL_DELIMITER:String = "url:";

    private static const VALID_URL_REGEX:RegExp = /^(ht|f)tps?:\/\/[^\s\.]+(\.[^\s\.]+)*((\/|\.)[^\s\.]+)+\/?$/;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    private function dataFileString():String
    {
        return URL_DELIMITER + _defaultValue.url;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  defaultValue
    //----------------------------------

    private var _defaultValue:DataFile;

    override public function get defaultValue():Object
    {
        return _defaultValue;
    }

    override public function set defaultValue(value:Object):void
    {
        _defaultValue = new DataFile(value.url);
    }

    //----------------------------------
    //  type
    //----------------------------------

    override public function get type():String
    {
        return GPParameterTypes.DATA_FILE;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function defaultValueFromString(description:String):void
    {
        var url:String = description.substr(URL_DELIMITER.length, description.length);
        _defaultValue = new DataFile(url);
    }

    override public function hasValidValue():Boolean
    {
        if (_defaultValue.url)
        {
            var validURLIndex:int = _defaultValue.url.search(VALID_URL_REGEX);
            return validURLIndex == 0;
        }
        else
        {
            return false;
        }
    }
}

}
