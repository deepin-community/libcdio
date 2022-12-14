#!/bin/bash

if test -z $srcdir ; then
  srcdir=$(pwd)
fi

if test "X$top_builddir" = "X" ; then
  top_builddir=$(pwd)/..
fi

. ${top_builddir}/test/check_common_fn

if test ! -x ../src/iso-info ; then
  exit 77
fi

BASE=$(basename $0 .sh)
fname=copying

opts="--quiet ${srcdir}/data/${fname}.iso --iso9660 "
test_iso_info  "$opts" ${fname}.dump ${srcdir}/${fname}.right
RC=$?
check_result $RC 'iso-info basic test' "$ISO_INFO $opts"

opts="--ignore --image ${srcdir}/data/${fname}.iso --extract $fname "
test_iso_read  "$opts" ${fname} ${srcdir}/copying.gpl
RC=$?
check_result $RC 'iso-read basic test' "$ISO_READ $opts"

if test -n "1"; then
  fname=copying-rr
  if test -n ""; then
      right_file=${fname}-mingw.right
  else
      right_file=${fname}.right
  fi
  opts="--quiet ${srcdir}/data/${fname}.iso --iso9660 "
  test_iso_info  "$opts" ${fname}.dump ${srcdir}/${right_file}
  RC=$?
  check_result $RC 'iso-info Rock Ridge test' "$ISO_INFO $opts"

  opts="--image ${srcdir}/data/${fname}.iso --extract COPYING"
  test_iso_read  "$opts" ${fname} ${srcdir}/copying-rr.gpl
  RC=$?
  check_result $RC 'iso-read RR test' "$ISO_READ $opts"
fi

if test -n "1" ; then
  BASE=$(basename $0 .sh)
  fname=joliet
  opts="--quiet ${srcdir}/data/${fname}.iso --iso9660 "
  test_iso_info  "$opts" ${fname}-nojoliet.dump ${srcdir}/${fname}.right
  RC=$?
  check_result $RC 'iso-info Joliet test' "$cmdline"
  opts="--quiet ${srcdir}/data/${fname}.iso --iso9660 --no-joliet "
  test_iso_info  "$opts" ${fname}-nojoliet.dump \
                 ${srcdir}/${fname}-nojoliet.right
  RC=$?
  check_result $RC 'iso-info --no-joliet test' "$cmdline"
fi

for fname in malformed malformed2; do
    opts="--quiet ${srcdir}/data/${fname}.iso -f "
    test_iso_info  "$opts" ${fname}.dump ${srcdir}/${fname}.right
    BAD_RC=$?
    if test $BAD_RC -ne  0 ; then
	check_result 0 "iso-info $fname test" "$cmdline"
    else
	echo "$0: in $fname Expecting nonzero return"
	RC=1
    fi
done


exit $RC

#;;; Local Variables: ***
#;;; mode:shell-script ***
#;;; eval: (sh-set-shell "bash") ***
#;;; End: ***
