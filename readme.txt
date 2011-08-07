==========================
ArcGIS Viewer for Flex 2.4
build date 2011-07-25
==========================

This file contains the complete source code for the ArcGIS Viewer for Flex 2.4.

============================
Getting Started - Developers
============================

See http://links.esri.com/flexviewer-gettingstarted-developers

1. in Flash Builder 4, Go to File Menu -> Import -> Flash Builder project.

2. Keeping "File" option selected, click "Browse..." button.

3. Select flexviewer-2.4-src.zip downloaded in step 1, e.g. "C:\Documents and Settings\jack\My Documents\flexviewer-2.4-src.zip".

4. "Extract new project to:" textbox will be automatically set to location where the project source will reside,
    e.g. "C:\Documents and Settings\jack\Adobe Flash Builder 4\FlexViewer.
    Do not put it onto your web server - you should separate your code location from your output.

5. Click "Finish" button. Project will be created and displayed in the Package Explorer window of Flash Builder 4, e.g. in this case FlexViewer.


Optionally:

1. Right click on this project (FlexViewer) -> Click "Properties" -> Click "Flex Build Path".

2. In the "Output folder" textbox at bottom, specify the location of your web server where your
    Flex Viewer should be deployed, e.g. in case of IIS web server, C:\Inetpub\wwwroot\flexviewerdebug.

3. In "Output folder URL" text box , specify the URL that matches with your output folder specified
    in last step, e.g. http://localhost/flexviewerdebug/

4. Click OK

5. Rebuild the project.

6. Select the project. Now let's run it - there are multiple ways of doing this.
    One way is to click green triangle button on top.
    Another way is click Ctrl-F11.
    A third way is to click "Run" menu, then select "Run Index".

7. Browser will open and Flex Viewer application will be displayed.


================
More Information
================

Flex Viewer: http://help.arcgis.com/en/webapps/flexviewer/index.html
Flex API http://help.arcgis.com/en/webapi/flex/index.html

Flex Viewer License agreement at http://www.esri.com/legal/pdfs/mla_e204_e300/english.pdf
