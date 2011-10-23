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

import com.esri.ags.Units;

public final class UnitMappingUtil
{
    public static function toPrettyUnits(units:String):String
    {
        var prettyUnits:String;

        switch (units)
        {
            case Units.FEET:
            {
                prettyUnits = "Feet";
                break;
            }
            case Units.MILES:
            {
                prettyUnits = "Miles";
                break;
            }
            case Units.NAUTICAL_MILES:
            {
                prettyUnits = "Nautical Miles";
                break;
            }
            case Units.METERS:
            {
                prettyUnits = "Meters";
                break;
            }
            case Units.KILOMETERS:
            {
                prettyUnits = "Kilometers";
                break;
            }
        }

        return prettyUnits;
    }

    public static function toEsriUnits(units:String):String
    {
        var esriUnits:String;

        switch (units)
        {
            case "Feet":
            {
                esriUnits = Units.FEET;
                break;
            }
            case "Miles":
            {
                esriUnits = Units.MILES;
                break;
            }
            case "Nautical Miles":
            {
                esriUnits = Units.NAUTICAL_MILES;
                break;
            }
            case "Meters":
            {
                esriUnits = Units.METERS;
                break;
            }
            case "Kilometers":
            {
                esriUnits = Units.KILOMETERS;
                break;
            }
        }

        return esriUnits;
    }
}

}
