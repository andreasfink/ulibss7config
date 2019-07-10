#!/bin/bash

H="DiameterSession_all.h"
X="DiameterSession.inc"


echo "//" >$X
echo "//  DiameterSession.inc" >>$X
echo "//  ulibss7config" >>$X
echo "//" >>$X
echo "//  Created by $USER on `date`" >>$H
echo "//  Copyright © 2019 Andreas Fink. All rights reserved." >>$X
echo "//" >>$X
echo "" >> $X


echo "//" >$H
echo "//  DiameterSession_all.h" >>$H
echo "//  ulibss7config" >>$H
echo "//" >>$H
echo "//  Created by $USER on `date`" >>$H
echo "//  Copyright © 2019 Andreas Fink. All rights reserved." >>$H
echo "//" >>$H
echo "" >> $H
echo "#import \"DiameterGenericSession.h\"" >> $H


for C in `cat DiameterCommands.txt`
do
	diameter-web-gen --name $C
    echo "#import \"DiameterSession$C.h\"" >> $H
    echo "SESSION(\"$C\",DiameterSession$C)" >> $X
done
echo "" >> $H



