#!/bin/sh
#   Copyright (C) 2012 Rocky Bernstein <rocky@gnu.org>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Tests to see that CD reading is correct (via cd-read). 

if test "X$abs_top_srcdir" = "X" ; then
  abs_top_srcdir=/src/external-vcs/savannah/libcdio
fi

if test "X$top_builddir" = "X" ; then
  top_builddir=/src/external-vcs/savannah/libcdio
fi

if test ! -x $top_builddir/example/extract ; then
  exit 77
fi

. ${top_builddir}/test/check_common_fn

extract_dir=/tmp/udf-$$
if test -d $extract_dir ; then
    rm -fr $extract_dir
fi

udf_iso=$abs_top_srcdir/test/data/test-udf1.iso
extract_program=$top_builddir/example/extract
cmd="$extract_program $udf_iso $extract_dir"
$cmd
RC=$?
check_result $RC "$cmd"

if test $RC -eq 0 ; then
    rm -fr $extract_dir
fi

exit $RC

#;;; Local Variables: ***
#;;; mode:shell-script ***
#;;; eval: (sh-set-shell "bash") ***
#;;; End: ***
