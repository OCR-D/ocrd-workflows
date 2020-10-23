# Introduction

As of now, the listed workflows are not completely ready work, but should give some good results on some material.
As concequence, some more refinements may be required for really good results.
This includes not only a custom model for `tesser-ocr-recognize`, but using some nifty adjustments in particular for croping, binarization or deskewing.

## Workflows

* `wf-g-1` is a rather simple workflow based on `sbb-textline`, which gives quite good results in term of finding text regions.
As downside, you do not really get any structure like headings.
The workflow is rather slow, but can be accelerated a lot using many cores.

* `wf-g-4` tries with some dewarping and uses `cis-ocropy-segment` to get more details ut of the regions.

## Tested materials

The workflows where used on the following works:

* http://tudigit.ulb.tu-darmstadt.de/show/Gue-883
* http://tudigit.ulb.tu-darmstadt.de/show/Gue-756-5
* http://tudigit.ulb.tu-darmstadt.de/show/Gue-846-1
* http://tudigit.ulb.tu-darmstadt.de/show/Gue-766-1
* http://tudigit.ulb.tu-darmstadt.de/show/Gue-491
* http://tudigit.ulb.tu-darmstadt.de/show/Gue-10734-35
* http://tudigit.ulb.tu-darmstadt.de/show/Gue-1345-1
* http://tudigit.ulb.tu-darmstadt.de/show/Gue-11660-24
* http://tudigit.ulb.tu-darmstadt.de/show/Gue-4635

Note that we did not run on the linked `jpg` files but on 300dpi `jpg` files obtained directly from the master `tif`.
