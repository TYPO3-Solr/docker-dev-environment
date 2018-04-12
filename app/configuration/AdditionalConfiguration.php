<?php

$GLOBALS['TYPO3_CONF_VARS']['SYS']['errorHandlerErrors'] = E_WARNING  | E_RECOVERABLE_ERROR | E_DEPRECATED ;
$GLOBALS['TYPO3_CONF_VARS']['SYS']['exceptionalErrors'] = E_WARNING | E_RECOVERABLE_ERROR | E_DEPRECATED ;

$GLOBALS['TYPO3_CONF_VARS']['SYS']['trustedHostsPattern']  = 'localhost|local.typo3.org';

$GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['solr']['sites'][1]['domains'][]  = 'local.typo3.org';

$GLOBALS['TYPO3_CONF_VARS']['EXT']['extConf']['tika'] = 'a:14:{s:9:"extractor";s:6:"server";s:7:"logging";s:1:"0";s:18:"showTikaSolrModule";s:1:"1";s:16:"excludeMimeTypes";s:0:"";s:13:"fileSizeLimit";s:3:"500";s:8:"tikaPath";s:0:"";s:14:"tikaServerPath";s:0:"";s:16:"tikaServerScheme";s:4:"http";s:14:"tikaServerHost";s:4:"tika";s:14:"tikaServerPort";s:4:"9998";s:10:"solrScheme";s:4:"http";s:8:"solrHost";s:9:"localhost";s:8:"solrPort";s:4:"8080";s:8:"solrPath";s:6:"/solr/";}';
