<?php
$out = '';
$raw = file_get_contents("https://api.wordpress.org/core/version-check/1.7/");
$rawdecoded = json_decode($raw, true);

foreach ($rawdecoded['offers'] as $k => $v) {
  echo sprintf("    - wordpress=%s\n", $v['version']);
}
