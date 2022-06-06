###################################################################
#                                                                 #
#   Copyright 2008 ASIP Solutions, Inc. All rights reserved.      #
#                   Copyright 2002 PEAS Project                   #
#                                                                 #
###################################################################

FHM_HOME=${ASIP_MEISTER_HOME}

FHMROOT=${FHM_HOME}/share/fhmdb
export FHMROOT
FHM_SEARCH_PATH=${FHMROOT}/basicfhmdb/computational:${FHMROOT}/basicfhmdb/storage:${FHMROOT}/workdb/FHM_work
export FHM_SEARCH_PATH
FHM_EST_DEFAULT_LIBRARY=OSAKA
export FHM_EST_DEFAULT_LIBRARY
#FHM_DS_DEFAULT_LANG=vhdl
#export FHM_DS_DEFAULT_LANG
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${FHM_HOME}/lib
export LD_LIBRARY_PATH
