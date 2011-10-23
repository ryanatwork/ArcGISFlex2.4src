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

public class GPParameterTypes
{
    public static const BOOLEAN:String = "boolean";
    public static const STRING:String = "string";
    public static const LONG:String = "long";
    public static const DOUBLE:String = "double";
    public static const DATE:String = "date";
    public static const DATA_FILE:String = "datafile";
    public static const LINEAR_UNIT:String = "linearunit";
    public static const RECORD_SET:String = "recordset";
    public static const FEATURE_RECORD_SET_LAYER:String = "featurerecordset";
    public static const RASTER_DATA_LAYER:String = "rasterdatalayer";
    public static const MULTI_VALUE:String = "multivalue";

    public static const GP_BOOLEAN:String = "GPBoolean";
    public static const GP_STRING:String = "GPString";
    public static const GP_LONG:String = "GPLong";
    public static const GP_DOUBLE:String = "GPDouble";
    public static const GP_DATE:String = "GPDate";
    public static const GP_DATA_FILE:String = "GPDataFile";
    public static const GP_LINEAR_UNIT:String = "GPLinearUnit";
    public static const GP_RECORD_SET:String = "GPRecordSet";
    public static const GP_FEATURE_RECORD_SET_LAYER:String = "GPFeatureRecordSetLayer";
    public static const GP_RASTER_DATA_LAYER:String = "GPRasterDataLayer";
    public static const GP_MULTI_VALUE:String = "GPMultiValue:GPString"; //only string multivalue supported
}

}
