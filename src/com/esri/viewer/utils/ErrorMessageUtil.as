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
package com.esri.viewer.utils
{

public class ErrorMessageUtil
{
    public static function getKnownErrorCauseMessage(faultCode:String):String
    {
        var message:String;

        switch (faultCode)
        {
            case "Channel.Security.Error":
            {
                message = "GIS Server is missing a crossdomain file.";
                break;
            }
            case "Server.Error.Request":
            case "400":
            case "404":
            {
                message = "Service does not exist or is inaccessible.";
                break;
            }
            case "499":
            {
                message = "You don't have permissions to access this service.";
                break;
            }
            default:
            {
                message = "Unknown error cause.";
            }
        }

        return message;
    }
}

}
